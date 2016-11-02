//
//  MessageModel.h
//  LiveDemo
//
//  Created by lxm on 2016/11/2.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageModel : JSONModel
@property(nonatomic,assign)int from_client_id;
@property(nonatomic,strong)NSString<Optional> *to_client_id;
@property(nonatomic,strong)NSString<Optional> *content;
@property(nonatomic,strong)NSString<Optional> *time;
@property(nonatomic,strong)NSString<Optional> *type;
@property(nonatomic,strong)NSString<Optional> *from_client_name;
@end
