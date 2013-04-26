//
//  AboutUSViewController.h
//  TrafficQuery
//
//  Created by tianjing on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUSViewController : UIViewController
{
    IBOutlet UIButton *telephoneButton;
    IBOutlet UIButton *networkButton;
}
-(IBAction)telephone:(id)sender;
-(IBAction)network:(id)sender;
@end
