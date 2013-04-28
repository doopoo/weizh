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
//    [_kaiguan release];
    [super dealloc];
   
}

-(IBAction)remind:(UIButton *)sender{
    UIButton* myBtn = (UIButton*)[self viewWithTag:2];
    [myBtn setBackgroundColor:[UIColor clearColor]];
    [myBtn setImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateNormal];
    [myBtn setImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateSelected];
    [myBtn addTarget:self action:@selector(touchEvent:) forControlEvents:UIControlEventTouchUpInside];
    if(isON == NO){
        
    }
}
-(void)touchEvent:(id)sender{
    UIButton* button = (UIButton*)sender;
    button.selected = !button.selected;
    if(button.imageView.image == [UIImage imageNamed:@"guan.png"]){
        NSLog(@"开着呢");
    }
    if(isON == NO){
        isON = YES;
    }
}

@end
