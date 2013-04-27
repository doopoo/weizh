//
//  AboutUSViewController.m
//  TrafficQuery
//
//  Created by tianjing on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

@end

@implementation AboutUSViewController

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
    UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top_panal_background.png"]];
    [topView setFrame:CGRectMake(0, 0, 320, 50)];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 6, 50, 30)];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_a.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_b.png"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(140, 8, 120, 40)];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    titleLable.text = @"关于我们";
    [self.view addSubview:topView];
    [self.view addSubview:titleLable];
    [self.view addSubview:backButton];
    [titleLable release];
    [backButton release];
    [topView release];
    // Do any additional setup after loading the view from its nib.
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)telephone:(id)sender{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://967968"]];
}

-(IBAction)network:(id)sender{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.chenglian.com"]];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [telephoneButton release];
    [networkButton release];
    [super dealloc];
}
@end
