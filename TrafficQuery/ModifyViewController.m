//
//  ModifyViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "ModifyViewController.h"
#import "CarViewController.h"
#import "carCommon.h"
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
    ////////////////////////////////
    CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    btn_shade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [btn_shade addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchDown];
    [btn_shade setBackgroundColor:[UIColor blackColor]];
    btn_shade.alpha = 0.5;
    [self.view addSubview:btn_shade];
    btn_shade.hidden = YES;
    show = YES;

    rightView=[[UIView alloc]initWithFrame:CGRectMake(320, 0, 120, screenHeight-20)];
    [rightView setBackgroundColor:[UIColor clearColor]];
    UIImage *image=[UIImage imageNamed:@"choose.png"];
    UIImageView *imageview=[[UIImageView alloc]initWithImage:image];
    imageview.frame=CGRectMake(0, 0, 120, screenHeight-20);
    
    UIButton *carManagerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 70)];
    [carManagerButton setTitle:@"车辆管理" forState:UIControlStateNormal];
    //    [carManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [carManagerButton setTitleColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    carManagerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    carManagerButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    UIImageView *carManagerView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 26, 25, 18)];
    carManagerView.image = [UIImage imageNamed:@"icon_car.png"];
    [carManagerButton addSubview:carManagerView];
    [carManagerView release];
    [carManagerButton setBackgroundImage:[UIImage imageNamed:@"set_top_n.png"] forState:UIControlStateNormal];
    [carManagerButton setBackgroundImage:[UIImage imageNamed:@"set_top_p.png"] forState:UIControlStateHighlighted];
    [carManagerButton addTarget:self action:@selector(managerCars:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *remindButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 68, 120, 72)];
    [remindButton setTitle:@"提醒设置" forState:UIControlStateNormal];
    [remindButton setTitleColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    remindButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    remindButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //    [remindButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [remindButton setBackgroundImage:[UIImage imageNamed:@"set_middle_n.png"] forState:UIControlStateNormal];
    [remindButton setBackgroundImage:[UIImage imageNamed:@"set_middle_p.png"] forState:UIControlStateHighlighted];
    [remindButton addTarget:self action:@selector(remind:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *remindView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 26, 25, 18)];
    remindView.image = [UIImage imageNamed:@"icon_remind.png"];
    [remindButton addSubview:remindView];
    [remindView release];
    
    UIButton *userInfButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 136, 120, 70)];
    [userInfButton setTitle:@"个人信息" forState:UIControlStateNormal];
    [userInfButton setTitleColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    userInfButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    userInfButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //    [userInfButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [userInfButton setBackgroundImage:[UIImage imageNamed:@"set_middle_n.png"] forState:UIControlStateNormal];
    [userInfButton setBackgroundImage:[UIImage imageNamed:@"set_middle_p.png"] forState:UIControlStateHighlighted];
    UIImageView *userInfView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 26, 25, 18)];
    userInfView.image = [UIImage imageNamed:@"icon_p.png"];
    [userInfButton addSubview:userInfView];
    [userInfView release];
    [userInfButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(0, screenHeight-158, 120, 70)];
    [shareButton setTitle:@"分享朋友" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    shareButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    shareButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"set_middle_n.png"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"set_middle_p.png"] forState:UIControlStateHighlighted];
    UIImageView *shareView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 26, 25, 18)];
    shareView.image = [UIImage imageNamed:@"icon_share.png"];
    [shareButton addSubview:shareView];
    [shareView release];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *aboutUSButton = [[UIButton alloc]initWithFrame:CGRectMake(0, screenHeight-90, 120, 70)];
    [aboutUSButton setTitle:@"关于我们" forState:UIControlStateNormal];
    [aboutUSButton setTitleColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    aboutUSButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    aboutUSButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //    [aboutUSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aboutUSButton setBackgroundImage:[UIImage imageNamed:@"set_bottom_n.png"] forState:UIControlStateNormal];
    [aboutUSButton setBackgroundImage:[UIImage imageNamed:@"set_bottom_p.png"] forState:UIControlStateHighlighted];
    UIImageView *chenglianView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 26, 25, 18)];
    chenglianView.image = [UIImage imageNamed:@"icon_chenglian.png"];
    [aboutUSButton addSubview:chenglianView];
    [chenglianView release];
    [aboutUSButton addTarget:self action:@selector(aboutUS:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightView addSubview:imageview];
    [rightView addSubview:carManagerButton];
    [rightView addSubview:remindButton];
    [rightView addSubview:userInfButton];
    [rightView addSubview:shareButton];
    [rightView addSubview:aboutUSButton];
    
    [carManagerButton release];
    [remindButton release];
    [userInfButton release];
    [shareButton release];
    [aboutUSButton release];
    [imageview release];
    [self.view addSubview:rightView];
    

    ////////////////////////////////
    
    
    
    carNameLabel.text = carNameStr;
    carPaiImageView.image = [UIImage imageNamed:carImageStr];
    carJiaTextField.text = carJiaStr;
    carPaiTextField.text = carPaiStr;
    savepai=[[NSString alloc]initWithString:self.carPaiTextField.text];
    carJiaTextField.delegate=self;
    
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
    for(int i = 0; i < num; i++)
    {
        NSString* tempCarNum = [[[self.carMutableArray objectAtIndex:i] objectForKey :@"carNum"] uppercaseString];
        NSMutableString* yu = [NSMutableString stringWithFormat:@"豫"];
        [yu appendString:tempCarNum];
//        NSLog(@"carPaiStr = %@", carPaiStr);
//        NSLog(@"yu = %@", yu);
//        NSLog(@"self.carImageStr = %@",self.carImageStr);
        if([savepai isEqualToString:yu])
        {//写入数据库中
            NSLog(@"self.carImageStr = %@",self.carImageStr);
            NSLog(@"self.carNameLabel.text = %@",self.carNameLabel.text);
            NSDictionary* carDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     [self.carPaiTextField.text substringFromIndex:1],@"carNum",
                                     self.carJiaTextField.text, @"carJiaNum",
                                     self.carImageStr,@"carImageNum",// 这个是数字
                                     self.carNameLabel.text, @"carImage", nil];//这个是文本

            //替换
            [self.carMutableArray replaceObjectAtIndex:i withObject:carDict];
            [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
            myCarCommon = [[carCommon alloc] initWithNibName:@"carCommon" bundle:nil];
            [myCarCommon.mainTableView reloadData];
            [self.navigationController pushViewController:myCarCommon animated:YES];
        }
        
    }    
}

//该方法为点击输入文本框要开始输入是调用的代理方法：就是把view上移到能看见文本框的地方
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    CGFloat keyboardHeight = 216.0f;
    if ((self.view.frame.size.height - keyboardHeight) <= (textField.frame.origin.y + textField.frame.size.height)){
        
        [UIView beginAnimations:@"srcollView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        textField.frame = CGRectMake(textField.frame.origin.x,textField.frame.origin.y-15, textField.frame.size.width, textField.frame.size.height);
        [UIView commitAnimations];
    }
    
}

//该方法为完成输入后要调用的代理方法：虚拟键盘隐藏后，要恢复到之前的文本框地方
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@"srcollView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    textField.frame = CGRectMake(textField.frame.origin.x, 227, textField.frame.size.width, textField.frame.size.height);
    [UIView commitAnimations];
}


-(IBAction)selectCar:(UIButton *)sender{
    carViewController = [[CarViewController alloc] initWithNibName:@"CarViewController" bundle:nil];
    carViewController.modifyDelegate = self;
    [self.navigationController pushViewController:carViewController animated:YES];
}
-(IBAction)setting:(id)sender{
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationDuration:0.5f];
    // show = YES;
    if(show){
        rightView.frame = CGRectMake(320-120, 0, 120, 480);
        show = NO;
        btn_shade.hidden = NO;
    }else{
        rightView.frame = CGRectMake(320, 0, 120, 480);
        show = YES;
        btn_shade.hidden = YES;
    }
    [UIView commitAnimations];
}
-(void)dealloc{
    [carNameStr release];
    [carImageStr release];
    [carJiaStr release];
    [carPaiStr release];
    [carPaiImageView release];
    [savepai release];
    [carNameLabel release];
    [super dealloc];
}

@end
