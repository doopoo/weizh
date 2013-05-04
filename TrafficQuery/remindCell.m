//
//  remindCell.m
//  TrafficQuery
//
//  Created by han zhen on 13-4-27.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "remindCell.h"
#import "RemindViewController.h"

@implementation remindCell
@synthesize carImageView, carNumberLabel, remindViewControllerDelegate;
@synthesize delegate=_delegate;
@synthesize kaiguan;

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
-(void)dealloc{
    [carImageView release];
    [carNumberLabel release];
   // [remindViewControllerDelegate release];
    [kaiguan release];
    [super dealloc];
   
}


-(IBAction)remind:(UIButton *)sender{
    
    if (_delegate)
    {
        [_delegate remind:sender];
    }

}


@end
