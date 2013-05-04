//
//  HomeIntroduce.h
//  TrafficQuery
//
//  Created by hz on 13-3-27.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "view.h"
#import "MBProgressHUD.h"
#import "ShareViewController.h"


#define NavbgHight  46
#define PLACECARNUMBER @"请输入车牌号码"
#define PLACECARJA     @"请输入车驾号码"
#define NUMBERS @"0123456789\n"

@class CarViewController;
@class CarInfoListViewController;
@class carCommon;
@class LoginViewController;
@class AboutUSViewController;
@class UserViewController;
@class RemindViewController;

@interface HomeIntroduce : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{
    MBProgressHUD* HUD;
    LoginViewController* loginViewController;
    AboutUSViewController* aboutUSViewController;
    
    UserViewController* userViewController;
    RemindViewController* remindViewController;
    
    UIView* rightView;
    UIView* xingshizhengView;
    UIImageView *xingshi;
    BOOL show;
    view* newView;
    UIButton* btn_shade;
    UIButton* tiShi_shade;
    carCommon* managerCars;
    
    CarViewController* carViewController;
    CarInfoListViewController* carInfoListViewController;
    
    
    UIPageControl* pageControl;
    UIPageControl* pageForFirstView;  //程序第一次启动页数控制器
   
    
    UITextField* carNumberField;//车牌号
    UITextField* carJaField;//车驾号
    UIImageView* iconImageView;//车型
  
    UIView* homeBgView;
    UILabel* titleLabel;
    
    NSString* leftBarTitle;
    BOOL isPush;
    NSString* iconNumStr;
    NSString* carNameStr;
    NSString* weifaCount;
    UILabel* selectIconLabel;
    NSMutableDictionary* carDataDict;
    NSMutableArray* carListArr;
 
}
@property(nonatomic, retain)NSMutableArray* carListArr;

@property(nonatomic, copy)NSString* weifaCount;
@property(nonatomic, copy)NSString* carNameStr;
@property(nonatomic, copy)NSString* iconNumStr;
@property(nonatomic, retain)UIImageView* iconImageView;
@property(nonatomic, copy)NSString* leftBarTitle;


@property(nonatomic, retain)IBOutlet UILabel* titleLabel;
@property(nonatomic, retain)IBOutlet UIView* homeBgView;
@property(nonatomic, retain)UILabel* selectIconLabel;

@property(nonatomic, retain)UITextField* carNumberField;
@property(nonatomic, retain)UITextField* carJaField;

-(IBAction)aboutSet:(id)sender;
//程序第一次启动时添加介绍页面视图
-(void)theAppFirstStartView;
//取文本域内text
-(UITextField*)getTextFieldNormal:(NSString*)placeMsg;
@end
