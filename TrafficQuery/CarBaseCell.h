//
//  CarBaseCell.h
//  TrafficQuery
//
//  Created by hz on 13-3-29.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarBaseCell : UITableViewCell
{
    BOOL useDarkBackground;
    
    UIImage* carImage;
    NSString* carName;
}

@property BOOL useDarkBackground;

@property(retain)UIImage* carImage;
@property(retain)NSString* carName;

@end
