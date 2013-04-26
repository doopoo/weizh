//
//  ModifyCell.m
//  TrafficQuery
//
//  Created by hz on 13-4-22.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "ModifyCell.h"
#import "ModifyViewController.h"
#import "carCommon.h"

#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]
@implementation ModifyCell
@synthesize carPaiLabel, carJiaLabelHidden, carBiaoImageView;
@synthesize commonDelegate;
//@synthesize modifyViewController;


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

    // Configure the view for the selected state
}
-(IBAction)showModifyViewController:(UIButton *)sender{
    [commonDelegate showModifyVC:self.carPaiLabel.text carJia:self.carJiaLabelHidden.text ];    
}

-(void)dealloc{
    [carPaiLabel release];
    [carJiaLabelHidden release];
    [carBiaoImageView release];
    [super dealloc];
}

@end
