//
//  TCViewController.m
//  LiveDemo
//
//  Created by lxm on 16/9/6.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import "TCViewController.h"

#import <SocketRocket/SocketRocket.h>
#import "UserModel.h"
#import "TCChatCell.h"
typedef enum {
    TCMsgPingStyle = 0x7E00,/*ping*/
    TCMsgLoginStyle,/*登录*/
    TCMsgReLoginStyle,/*重新登录*/
    TCMsgSayStyle/*发言*/
}TCMsgActionStyle;

@interface TCMessage : NSObject

- (instancetype)initWithMessage:(NSString *)message incoming:(BOOL)incoming;

@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, assign, readonly, getter=isIncoming) BOOL incoming;

@end

@implementation TCMessage

- (instancetype)initWithMessage:(NSString *)message incoming:(BOOL)incoming
{
    self = [super init];
    if (!self) return self;

    _incoming = incoming;
    _message = message;

    return self;
}

@end


@interface TCViewController () <SRWebSocketDelegate, UITextViewDelegate>
{
    SRWebSocket *_webSocket;
    NSMutableArray<TCMessage *> *_messages;
}

@end

@implementation TCViewController

///--------------------------------------
#pragma mark - View
///--------------------------------------

- (void)viewDidLoad;
{
    [super viewDidLoad];

    _messages = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self reconnect:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [_inputView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [_webSocket close];
    _webSocket = nil;
}

///--------------------------------------
#pragma mark - Actions
///--------------------------------------
- (NSDictionary*)fetchMsgKey{
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    [ret setObject:[NSNumber numberWithInt:TCMsgPingStyle]       forKey:@"ping"];
    [ret setObject:[NSNumber numberWithInt:TCMsgLoginStyle]    forKey:@"login"];
    [ret setObject:[NSNumber numberWithInt:TCMsgReLoginStyle]           forKey:@"relogin"];
    [ret setObject:[NSNumber numberWithInt:TCMsgSayStyle]           forKey:@"say"];
    return ret;
}

- (IBAction)reconnect:(id)sender
{
    _webSocket.delegate = nil;
    [_webSocket close];

    _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:7272"]];
    _webSocket.delegate = self;

    self.title = @"Opening Connection...";
    [_webSocket open];
}

- (void)sendPing:(id)sender;
{
//    [_webSocket sendPing:nil];
    NSDictionary *sendDic = @{@"type":@"login",
                              @"room_id":@"1",
                              @"client_name":@"bb",
                              @"client_type":@"ios"
                              };
    [_webSocket send:[sendDic JSONString]];
}

///--------------------------------------
#pragma mark - Messages
///--------------------------------------

- (void)_addMessage:(TCMessage *)message
{
    [_messages addObject:message];
    [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:_messages.count - 1 inSection:0] ]
                          withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
}

///--------------------------------------
#pragma mark - UITableViewController
///--------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCMessage *message = _messages[indexPath.row];

    TCChatCell *cell = [self.tableView dequeueReusableCellWithIdentifier:message.incoming ? @"ReceivedCell" : @"SentCell"
                                                            forIndexPath:indexPath];

    cell.textView.text = message.message;
    cell.nameLabel.text = message.incoming ? @"Other" : @"Me";

    return cell;
}

///--------------------------------------
#pragma mark - SRWebSocketDelegate
///--------------------------------------

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    self.title = @"Connected!";
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);

    self.title = @"Connection Failed! (see logs)";
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received \"%@\"", [message objectFromJSONString]);
    id msgObj = [message objectFromJSONString];
    switch ([[[self fetchMsgKey] objectForKey:[msgObj objectForKey:@"type"]] integerValue]) {
        case TCMsgPingStyle:
        {
            NSDictionary *sendDic = @{@"type":@"pong",
                                      @"client_type":@"ios"};
            [_webSocket send:[sendDic JSONString]];
        }
            break;
        case TCMsgLoginStyle:
        {
            NSError *jsonError;
            _rModel = [[UserModel alloc] initWithString:[msgObj JSONString] error:&jsonError];
            if(jsonError)
            {
                CSAlert(@"json error");
            }
            
            [_messages addObject:[[TCMessage alloc] initWithMessage:[NSString stringWithFormat:@"用户\"%@\"登录了",_rModel.client_name] incoming:NO]];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
        }
        break;
        case TCMsgReLoginStyle:
        {
            
        }
        break;
        case TCMsgSayStyle:
        {
            NSError *jsonError;
            MessageModel *aModel = [[MessageModel alloc] initWithString:[msgObj JSONString] error:&jsonError];
            if(jsonError)
            {
                CSAlert(@"json error");
            }
            /*判断是广播还是私信*/
            if([aModel.to_client_id isEqualToString:@"all"]){
                /*判断本机用户id是否跟消息发送者id相同*/
                if(aModel.from_client_id!=_rModel.client_id){
                    [_messages addObject:[[TCMessage alloc] initWithMessage:[NSString stringWithFormat:@"%@说：%@",aModel.from_client_name, aModel.content] incoming:YES]];
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
                    
                }
            }else{
                /*判断是否对本人私信*/
                if([aModel.to_client_id intValue]==_rModel.client_id){
                    [_messages addObject:[[TCMessage alloc] initWithMessage:[NSString stringWithFormat:@"%@ 私信对你说：%@",aModel.from_client_name, aModel.content] incoming:YES]];
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
                }
            }
        }
        break;
        default:
            break;
    }
}

//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(nonnull NSString *)string
//{
//    NSLog(@"Received \"%@\"", string);
//    [self _addMessage:[[TCMessage alloc] initWithMessage:string incoming:YES]];
//}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    self.title = @"Connection Closed! (see logs)";
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"WebSocket received pong");
}

///--------------------------------------
#pragma mark - UITextViewDelegate
///--------------------------------------

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text rangeOfString:@"\n"].location != NSNotFound) {
        NSString *message = [textView.text stringByReplacingCharactersInRange:range withString:text];
        message = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSDictionary *sendDic = @{@"type":@"say",
                                  @"room_id":@"1",
                                  @"client_id":[NSString stringWithFormat:@"%d",_rModel.client_id],
                                  @"client_name":_rModel.client_name,
                                  @"to_client_id":@"all",
                                  @"client_type":@"ios",
                                  @"content":message};
        [_webSocket send:[sendDic JSONString]];

        [self _addMessage:[[TCMessage alloc] initWithMessage:message incoming:NO]];

        textView.text = nil;
        return NO;
    }
    return YES;
}

@end
