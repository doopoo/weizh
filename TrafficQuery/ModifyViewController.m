//
//  ModifyViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "ModifyViewController.h"
#import "CarViewController.h"
#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]

@interface ModifyViewController ()

@end

@implementation ModifyViewController
@synthesize carPaiImageView, carJiaTextField, carNameLabel, carPaiTextField;
@synthesize carNameStr, carImageStr, carJiaStr, carPaiStr;
@synthesize carMutableArray, carDictionary;

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
    carNameLabel.text = carNameStr;
    carPaiImageView.image = [UIImage imageNamed:carImageStr];
    carJiaTextField.text = carJiaStr;
    carPaiTextField.text = carPaiStr;
    
    UITapGestureRecognizer* tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    [self initMainTableView];
    
}
-(void)initMainTableView{
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:CARLISTFILEPATH]){
        [fileManage createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
    }
    self.carMutableArray = [NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH];
}
//添加手势,让键盘消失
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    
    [carPaiTextField resignFirstResponder];
    
    [carJiaTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存数据
//[self.carMutableArray removeObjectAtIndex:indexPath.row];
//[self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
-(IBAction)saveChange:(UIButton *)sender{
    int num = [self.carMutableArray count];
    /*
    for(int i = 0; i < num; i++){
        NSString* tempCarNum = [[[self.carMutableArray objectAtIndex:i] objectForKey :@"carNum"] uppercaseString];
        NSMutableString* yu = [NSMutableString stringWithFormat:@"豫"];
        [yu appendString:tempCarNum];
        NSLog(@"carPaiStr = %@", carPaiStr);
        NSLog(@"yu = %@", yu);
        if([carPaiStr isEqualToString:yu]){//写入数据库中
            NSLog(@"调用了");
            [[self.carMutableArray objectAtIndex:i] setValue:self.carPaiTextField.text forKey:@"carNum"];
            [[self.carMutableArray objectAtIndex:i] setValue:self.carJiaTextField.text forKey:@"carJiaNum"];
            [[self.carMutableArray objectAtIndex:i] setValue:self.carNameLabel.text forKey:@"carImage"];
            [[self.carMutableArray objectAtIndex:i] setValue:self.carImageStr forKey:@"carImagenum"];
            [[self.carMutableArray objectAtIndex:i] writeToFile:CARLISTFILEPATH atomically:YES];
//            break;
            
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    */
    
    
    
}



-(IBAction)selectCar:(UIButton *)sender{
    carViewController = [[CarViewController alloc] initWithNibName:@"CarViewController" bundle:nil];
    carViewController.modifyDelegate = self;
    [self.navigationController pushViewController:carViewController animated:YES];
}
-(void)dealloc{
    [carNameStr release];
    [carImageStr release];
    [carJiaStr release];
    [carPaiStr release];
    [carPaiImageView release];
    
    [carNameLabel release];
    [super dealloc];
}

@end