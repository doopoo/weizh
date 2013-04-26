//
//  IndexViewController.h
//  TrafficQuery
//
//  Created by hz on 13-4-11.
//  Copyright (c) 2013年 hz. All rights reserved.
//
//程序第二次启动时加载的页面
#import <UIKit/UIKit.h>
#import "view.h"
#import "MBProgressHUD.h"
@class HomeIntroduce;//回到添加车辆上吧
@class CarInfoListViewController;
@class LoginViewController;
@class carCommon;
@class AboutUSViewController;
@class UserViewController;

@interface IndexViewController : UIViewController{
    MBProgressHUD* HUD;
    
    AboutUSViewController* aboutUSViewController;
    LoginViewController* loginViewController;
    carCommon* managerCars;
    
    UserViewController* userViewController;
    
    UIView* rightView;
    BOOL show;
    view* newView;
    UIButton* btn_shade;
    
    UITableView* mainTableView;
    HomeIntroduce* addCarViewController;
    
    CarInfoListViewController* carInfoListViewController;
    
    NSMutableDictionary* carDictionary;//车辆数据
    NSMutableArray* carMutableArray;
}
@property(nonatomic, retain)IBOutlet UITableView* mainTableView;
@property(nonatomic, retain)NSMutableDictionary* carDictionary;
@property(nonatomic, assign)HomeIntroduce* addCarViewController;
@property(nonatomic, assign)CarInfoListViewController* carInfoListViewController;
@property(nonatomic, retain)NSMutableArray* carMutableArray;
-(IBAction)setting_pressed:(id)sender;

-(void)initMainTableView;
//-(void)addNewCar;
-(void)showHomeIntroduce;
-(void)showCarInfoViewController:(NSString*)numberStr carJaNumber:(NSString*)carJaStr;

@end
