//
//  UpgradeViewController.m
//  TrafficQuery
//
//  Created by hz on 13-5-3.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "UpgradeViewController.h"
#define USERFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/User.plist"]


@interface UpgradeViewController ()

@end

@implementation UpgradeViewController
@synthesize userID;

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
    NSFileManager* userFile = [NSFileManager defaultManager];
    if(![userFile fileExistsAtPath:USERFILEPATH]){
        [userFile createFileAtPath:USERFILEPATH contents:nil attributes:nil];
    }
    userDic = [[NSDictionary alloc] initWithContentsOfFile:USERFILEPATH];
    userID.text = [userDic objectForKey:@"userID"];
    
    
}
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)pay:(id)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
