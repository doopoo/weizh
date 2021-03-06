//
//  ModifyViewController.h
//  TrafficQuery
//
//  Created by hz on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarViewController;
@class carCommon;
@class CarInfoListViewController;
@class LoginViewController;
@class AboutUSViewController;
@class UserViewController;
@class RemindViewController;
@class carCommon;

@interface ModifyViewController : UIViewController<UITextFieldDelegate>{
    
    
    AboutUSViewController* aboutUSViewController;
    LoginViewController* loginViewController;
    UserViewController* userViewController;
    RemindViewController* remindViewController;
    carCommon* managerCars;
//    CarInfoListViewController;
    
    UIView* rightView;
    carCommon* myCarCommon;
    CarViewController* carViewController;
    UILabel* carNameLabel;
    UITextField* carPaiTextField;
    UITextField* carJiaTextField;
    UIImageView* carPaiImageView;
    NSString* carImageStr;
    NSString* carNameStr;
    NSString* carPaiStr;
    NSString* carJiaStr;
    NSString* savepai;
    
    NSMutableDictionary* carDictionary;
    NSMutableArray* carMutableArray;
    BOOL show;
    UIButton* btn_shade;
}
@property(nonatomic, assign)NSString* carPaiStr;
@property(nonatomic, assign)NSString* carJiaStr;
@property(nonatomic, retain)NSString* carImageStr;
@property(nonatomic, assign)NSString* carNameStr;
@property(nonatomic, retain)IBOutlet UILabel* carNameLabel;
@property(nonatomic, retain)IBOutlet UITextField* carPaiTextField;
@property(nonatomic, retain)IBOutlet UITextField* carJiaTextField;
@property(nonatomic, retain)IBOutlet UIImageView* carPaiImageView;
@property(nonatomic, retain)NSMutableDictionary* carDictionary;
@property(nonatomic, retain)NSMutableArray* carMutableArray;

-(IBAction)setting:(id)sender;
-(IBAction)goBack:(UIButton*)sender;
-(IBAction)saveChange:(UIButton*)sender;
-(IBAction)selectCar:(UIButton*)sender;

@end
