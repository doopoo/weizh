//
//  CarBaseCell.m
//  TrafficQuery
//
//  Created by hz on 13-3-29.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "CarBaseCell.h"

@implementation CarBaseCell

@synthesize useDarkBackground, carImage, carName;

-(void)setUseDarkBackground:(BOOL)flag{
    if (flag != useDarkBackground || !self.backgroundView){
        useDarkBackground = flag;
        NSString* backgroundImagePath= [[NSBundle mainBundle] pathForResource:useDarkBackground ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
        UIImage* backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        self.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView.frame = self.bounds;
    }
}

-(void)dealloc{
    [carImage release];
    [carName release];
    [super dealloc];
}


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

@end
