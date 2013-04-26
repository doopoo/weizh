//
//  IndexCarCell.m
//  TrafficQuery
//
//  Created by hz on 13-4-11.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "IndexCarCell.h"
#import "CarInfoListViewController.h"
#import "CarManager.h"
#import "IndexViewController.h"
#import "carCommon.h"

#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]

@implementation IndexCarCell
@synthesize carNumberLabel, carImageView;
@synthesize delegate;
@synthesize commonDelegate;
@synthesize carJiaHiddenLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(void)dealloc{
    [carNumberLabel release];
    [carJiaHiddenLabel release];
    [super dealloc];
}
//传值 
-(IBAction)showCarInfoListVC:(UIButton *)sender
{
    
    //UILabel* carNumberLabel;
    NSLog(@"carNumberLabel 中国=%@",self.carNumberLabel.text);
    NSLog(@"carArr = %@",[CarManager sharedInstance].carsArr);//
    
  //-  NSMutableArray* carJiaName = [[NSMutableArray alloc] initWithCapacity:nums];
    
    NSString* carNumStr = [self.carNumberLabel.text substringFromIndex:1];
    NSString* carJiaStr = self.carJiaHiddenLabel.text;
    [delegate showCarInfoViewController:carNumStr carJaNumber:carJiaStr];
}


@end
