//
//  RemindViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-24.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "RemindViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface RemindViewController ()

@end

@implementation RemindViewController




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

-(IBAction)remindBtn:(id)sender{
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/add/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requestForm setPostValue:@"阿斯顿·马丁" forKey:@"plate"];
    [requestForm setPostValue:@"599890" forKey:@"vin"];
    [requestForm setPostValue:@"116.jpg" forKey:@"imgName"];
    [requestForm setPostValue:@"a222fx" forKey:@"brand"];
    [requestForm startSynchronous];
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);
}

-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
























- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
