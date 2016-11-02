//
//  TCViewController.h
//  LiveDemo
//
//  Created by lxm on 16/9/6.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@class UserModel;
@interface TCViewController : UITableViewController
{
    UserModel *_rModel;
}
@property (nonatomic, strong) IBOutlet UITextView *inputView;

- (IBAction)reconnect:(id)sender;
- (IBAction)sendPing:(id)sender;

@end
