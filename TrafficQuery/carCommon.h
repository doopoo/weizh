//
//  carCommon.h
//  TrafficQuery
//
//  Created by hz on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//
//车辆管理
#import <UIKit/UIKit.h>
@class IndexViewController;
@class ModifyViewController;
@interface carCommon : UIViewController{
    UITableView* mainTableView;
    
    NSMutableDictionary* carDictionary;
    NSMutableArray* carMutableArray;
    UIButton* deleteButton;
    IndexViewController* indexViewController;
    ModifyViewController* modifyViewController;
    
}
@property(nonatomic, retain)IBOutlet UIButton* deleteButton;
@property(nonatomic, retain)IBOutlet UITableView* mainTableView;
@property(nonatomic, retain)NSMutableDictionary* carDictionary;
@property(nonatomic, retain)NSMutableArray* carMutableArray;

-(IBAction)deleteCar:(UIButton*)sender;
-(void)initMainTableView;
-(IBAction)goBack:(UIButton*)sender;
//-(void)showCarInfoViewController:(NSString*)numberStr carJaNumber:(NSString*)carJaStr;
-(void)showModifyVC:(NSString*)carPaiStr carJia:(NSString*)carJiaStr;
@end
