//
//  RemindViewController.h
//  TrafficQuery
//
//  Created by hz on 13-4-24.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableDictionary* carDictionary;//车辆信息
    NSMutableArray* carMutableArray;
    UITableView* mainTableView;
    int n;
}
@property(nonatomic, retain)IBOutlet UITableView* mainTableView;
@property(nonatomic, retain)NSMutableDictionary* carDictionary;
@property(nonatomic, retain)NSMutableArray* carMutableArray;

-(void)initMainTableView;
-(IBAction)remindBtn:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)baoche:(id)sender;
@end
