//
//  ModifyCell.h
//  TrafficQuery
//
//  Created by hz on 13-4-22.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModifyViewController;
@class carCommon;

@interface ModifyCell : UITableViewCell{
    UILabel* carPaiLabel;
    UILabel* carJiaLabelHidden;
    UIImageView* carBiaoImageView;
    carCommon* commonDelegate;
    ModifyViewController* modifyViewController;
    
}
//@property(nonatomic, assign)ModifyViewController* modifyViewController;
@property(nonatomic, assign)carCommon* commonDelegate;
@property(nonatomic, retain)IBOutlet UILabel* carPaiLabel;
@property(nonatomic, retain)IBOutlet UILabel* carJiaLabelHidden;
@property(nonatomic, retain)IBOutlet UIImageView* carBiaoImageView;

-(IBAction)showModifyViewController:(UIButton*)sender;

@end
