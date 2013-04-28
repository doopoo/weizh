//
//  remindCell.h
//  TrafficQuery
//
//  Created by han zhen on 13-4-27.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RemindViewController;

@interface remindCell : UITableViewCell{
    UILabel* carNumberLabel;
    UIImageView* carImageView;

//    UIButton *kaiguan;
    RemindViewController* remindViewControllerDelegate;
    BOOL isON;
}
@property(nonatomic, retain)IBOutlet UILabel* carNumberLabel;
@property(nonatomic, retain)IBOutlet UIImageView* carImageView;
@property(nonatomic, assign)RemindViewController* remindViewControllerDelegate;
//@property (retain, nonatomic) IBOutlet UIButton *kaiguan;

-(IBAction)remind:(UIButton*)sender;


@end
