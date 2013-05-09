//
//  CarManager.h
//  TrafficQuery
//
//  Created by hz on 13-4-15.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarManager : NSObject{
    NSMutableDictionary* carsDic;
//    NSArray* carsArr;
    NSMutableArray* carsArr;
    NSString* orderId;
    
}
//是否已经登陆
@property BOOL isLogin;
@property(nonatomic, retain)NSString* orderId;
@property(nonatomic, retain)NSMutableDictionary* carsDic;
//@property(nonatomic, retain)NSArray* carsArr;
@property(nonatomic, retain)NSMutableArray* carsArr;
+(CarManager*)sharedInstance;
-(void)saveUserNameAndPwd:(NSString*)userName andPwd:(NSString*)pwd;
-(NSString*)getUserName;
-(NSString*)getPwd;
@end
