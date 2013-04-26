//
//  AddButtonCell.m
//  TrafficQuery
//
//  Created by hz on 13-4-11.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "AddButtonCell.h"
#import "CarViewController.h"
#import "HomeIntroduce.h"
#import "IndexViewController.h"

@implementation AddButtonCell
@synthesize carViewController;
@synthesize indexVC;
//@synthesize addButton;

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
-(IBAction)showSelectCarVC:(UIButton*)sender{
    [indexVC showHomeIntroduce];
}

@end
