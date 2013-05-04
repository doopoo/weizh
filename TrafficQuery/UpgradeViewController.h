//
//  UpgradeViewController.h
//  TrafficQuery
//
//  Created by hz on 13-5-3.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UpgradeViewController : UIViewController{
    UILabel* userID;
    NSDictionary* userDic;
}
@property(nonatomic, retain)IBOutlet UILabel* userID;
-(IBAction)goBack:(id)sender;
-(IBAction)pay:(id)sender;
@end
