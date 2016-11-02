//
//  UserModel.h
//  LiveDemo
//
//  Created by lxm on 2016/11/2.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol RoomUserList
@end
@interface RoomUserList:JSONModel
@property(nonatomic,assign)int client_id;
@property(nonatomic,strong)NSString<Optional> *client_name;
@end
@interface UserModel : JSONModel
@property(nonatomic,assign)int client_id;
@property(nonatomic,strong)NSString<Optional> *client_name;
@property(nonatomic,strong)NSString<Optional> *time;
@property(nonatomic,strong)NSString<Optional> *type;
@property(nonatomic,strong)NSArray<RoomUserList,Optional> *client_list;
@end
