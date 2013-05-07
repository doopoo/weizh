//
//  RemindViewController.h
//  TrafficQuery
//
//  Created by hz on 13-4-24.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "remindCell.h"
@class LoginViewController;
@class IndexViewController;//返回视图
@class VIPViewController;


@interface RemindViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,remindCelldelegate>{
    NSMutableDictionary* carDictionary;//车辆信息
    NSMutableArray* carMutableArray;
    UITableView* mainTableView;
    int n;
    BOOL isON;
    NSString *loginIsYes;
    
    LoginViewController* loginViewController;
    NSDictionary* userDic;
    IndexViewController* indexViewController;
    VIPViewController* vipViewController;
    
    
    UIButton* myBtn;
    int m;
}
@property(nonatomic, retain)IBOutlet UITableView* mainTableView;
@property(nonatomic, retain)NSMutableDictionary* carDictionary;
@property(nonatomic, retain)NSMutableArray* carMutableArray;

-(void)initMainTableView;
-(IBAction)remindBtn:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)baoche:(id)sender;
@end
