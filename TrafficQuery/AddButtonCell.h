//
//  AddButtonCell.h
//  TrafficQuery
//
//  Created by hz on 13-4-11.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeIntroduce;
@class IndexViewController;

@interface AddButtonCell : UITableViewCell{
   // UIButton* addButton;
    HomeIntroduce* carViewController;
    IndexViewController* indexVC;
}
//@property(nonatomic, retain)IBOutlet UIButton* addButton;
@property(nonatomic, assign)HomeIntroduce* carViewController;
@property(nonatomic, assign)IndexViewController* indexVC;
-(IBAction)showSelectCarVC:(UIButton*)sender;

@end
