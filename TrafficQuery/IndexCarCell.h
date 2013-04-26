//
//  IndexCarCell.h
//  TrafficQuery
//
//  Created by hz on 13-4-11.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarInfoListViewController;
@class IndexViewController;
@class carCommon;

@interface IndexCarCell : UITableViewCell{
    
    UILabel* carJiaHiddenLabel;
    
    UILabel* carNumberLabel;
    UIImageView* carImageView;
    CarInfoListViewController* carInfoListViewController;
    
    IndexViewController* delegate;
    
    carCommon* commonDelegate;
}
@property(nonatomic, retain)IBOutlet UILabel* carJiaHiddenLabel;
@property(nonatomic, assign)IndexViewController* delegate;
@property(nonatomic, assign)carCommon* commonDelegate;
@property(nonatomic, retain)IBOutlet UILabel* carNumberLabel;
//@property(nonatomic, assign)CarInfoListViewController* carInfoListViewController;
@property(nonatomic, retain)IBOutlet UIImageView* carImageView;

-(IBAction)showCarInfoListVC:(UIButton*)sender;
@end
