//
//  VIPViewController.m
//  TrafficQuery
//
//  Created by hz on 13-5-3.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "VIPViewController.h"
#import "RemindViewController.h"
#import "UpgradeViewController.h"

@interface VIPViewController ()

@end

@implementation VIPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)upgrade:(id)sender{
    upgradeViewController = [[UpgradeViewController alloc] initWithNibName:@"UpgradeViewController" bundle:nil];
    [self.navigationController pushViewController:upgradeViewController animated:YES];
}
-(IBAction)goBack:(id)sender{
    remindViewController = [[RemindViewController alloc] initWithNibName:@"RemindViewController" bundle:nil];
    [self.navigationController pushViewController:remindViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
