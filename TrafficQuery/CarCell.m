//
//  CarCell.m
//  TrafficQuery
//
//  Created by hz on 13-3-29.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell

-(void)setBackgroundColor:(UIColor*)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    carImageView.backgroundColor = backgroundColor;
    carNameLabel.backgroundColor = backgroundColor;
}

-(void)setCarImage:(UIImage *)newImage{
    [super setCarImage:newImage];
    carImageView.image = newImage;
}
-(void)setCarName:(NSString *)newName{
    [super setCarName:newName];
    carNameLabel.text = newName;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
