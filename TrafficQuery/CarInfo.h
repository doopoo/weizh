//
//  CarInfo.h
//  TrafficQuery
//
//  Created by hz on 13-4-2.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfo : UITableViewCell{
    UILabel* whenLabel;
    UILabel* whereLabel;
    UILabel* whyLabel;
    UILabel* fakuanLabel;
    UILabel* koufenLabel;
    UILabel* caijueStatusLabel;
    UILabel* jiaokuanStatusLabel;
}

@property(nonatomic, retain)IBOutlet UILabel* whenLabel;
@property(nonatomic, retain)IBOutlet UILabel* whereLabel;
@property(nonatomic, retain)IBOutlet UILabel* whyLabel;
@property(nonatomic, retain)IBOutlet UILabel* fakuanLabel;
@property(nonatomic, retain)IBOutlet UILabel* koufenLabel;
@property(nonatomic, retain)IBOutlet UILabel* caijueStatusLabel;
@property(nonatomic, retain)IBOutlet UILabel* jiaokuanStatusLabel;
-(float )setlablefont:(UILabel *)label gettext:(NSString *)text;

@end
