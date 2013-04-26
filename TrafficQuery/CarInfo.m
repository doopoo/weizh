//
//  CarInfo.m
//  TrafficQuery
//
//  Created by hz on 13-4-2.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo
@synthesize whenLabel, whereLabel, whyLabel, fakuanLabel, koufenLabel;
@synthesize caijueStatusLabel, jiaokuanStatusLabel;


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
-(float )setlablefont:(UILabel *)label gettext:(NSString *)text
{
    float m,n;
    UIFont *font;
    
    font = [UIFont fontWithName:@"Arial" size:13.0f];
    
    //设定宽度，高度无限高
    CGSize constraintSize = CGSizeMake(180.0f, MAXFLOAT);
    //计算实际需要得视图大小
    CGSize labelSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByCharWrapping];
    m=label.frame.size.height;
    NSLog(@"%f",m);
    CGRect rect = CGRectMake(label.frame.origin.x, label.frame.origin.y, labelSize.width, labelSize.height);
    label.frame=rect;
    n=label.frame.size.height;
    NSLog(@"%f",n);
    label.font = font;
    label.text = text;
    return n-m;
}

@end
