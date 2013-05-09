//
//  HomeIntroduce.m
//  TrafficQuery
//
//  Created by hz on 13-3-27.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "HomeIntroduce.h"
#import <QuartzCore/QuartzCore.h>
#import "CarViewController.h"
#import "CarInfoListViewController.h"
#import "CarManager.h"
#import "carCommon.h"
#import "LoginViewController.h"
#import "AboutUSViewController.h"
#import "UserViewController.h"
#import "RemindViewController.h"


#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]

@interface HomeIntroduce ()

@end

@implementation HomeIntroduce
@synthesize carNumberField, carJaField;
@synthesize titleLabel, homeBgView;
@synthesize leftBarTitle;
@synthesize iconImageView, iconNumStr, selectIconLabel, carNameStr;
@synthesize weifaCount;
@synthesize carListArr;


-(void)share:(id)sender{
    
    ShareViewController *viewController = [[ShareViewController alloc]init];


    [self.navigationController pushViewController:viewController animated:YES];
    [self aboutSet:self];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    btn_shade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight)];
    [btn_shade addTarget:self action:@selector(aboutSet:) forControlEvents:UIControlEventTouchDown];
    [btn_shade setBackgroundColor:[UIColor blackColor]];
    btn_shade.alpha = 0.5;
    [self.view addSubview:btn_shade];
    btn_shade.hidden = YES;
    
    tiShi_shade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight)];
    [tiShi_shade addTarget:self action:@selector(tiShi) forControlEvents:UIControlEventTouchDown];
    [tiShi_shade setBackgroundColor:[UIColor blackColor]];
    tiShi_shade.alpha = 0.5;
    [self.view addSubview:tiShi_shade];
    tiShi_shade.hidden = YES;

    show = YES;
    newView = [[view alloc] initWithFrame:CGRectMake(0, 0, 320,screenHeight)];
    newView.backgroundColor = [UIColor clearColor];
    
    //右边的目录---也成一个函数
    
    rightView=[[UIView alloc]initWithFrame:CGRectMake(320, 0, 120, screenHeight-20)];
    [rightView setBackgroundColor:[UIColor clearColor]];
    
    xingshizhengView=[[UIView alloc]initWithFrame:CGRectMake(320,100,0,0)];
    xingshi = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingshizheng.png"]];
    xingshi.frame = CGRectMake(0,0,0, 0);
    [xingshizhengView addSubview:xingshi];
    [xingshi release];

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
    [self.view addSubview:xingshizhengView];
    

    
    UITapGestureRecognizer* tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    
    UIImageView* homeBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeBig_bg.jpg"]];
    homeBg.userInteractionEnabled = YES;
    homeBg.frame = CGRectMake(0, -20, 320, screenHeight);
    [self.homeBgView addSubview:homeBg];
    


    //////////////////////////////////////
    carNumberField = [self getTextFieldNormal:PLACECARNUMBER];
    carJaField     = [self getTextFieldNormal:PLACECARJA];
    
    //主页面的设置
    //car icon selected
   /*
    selectIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 210, 40)];
    selectIconLabel.text = @"选择汽车品牌";//要修改
    selectIconLabel.backgroundColor = [UIColor clearColor];
    selectIconLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    selectIconLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:23];
    
    */
    
    CGRect bgFrameCarSelect = CGRectMake(20, -5, 280, 80);
    UIImageView* bgCarSelect = [[UIImageView alloc] initWithFrame:bgFrameCarSelect];
    bgCarSelect.userInteractionEnabled = YES;
    bgCarSelect.image = [UIImage imageNamed:@"ic_more_item_default.png"];
    [bgCarSelect addSubview:selectIconLabel];
    [selectIconLabel release];
    [homeBgView addSubview:bgCarSelect];
    [bgCarSelect release];
    //[homeBg addSubview:bgCarSelect];
    //[self.view addSubview:bgCarSelect];
    
    carJaField.delegate=self;
    carNumberField.delegate=self;

    UIButton* selectCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //selectCarBtn.userInteractionEnabled = YES;
    //[bgCarSelect release];
    
    
    //image icon
    //这个地方进行修改 prompt.png
    
    CGRect iconImageFrame = CGRectMake(5, 10, 56, 42);
    iconImageView = [[UIImageView alloc] initWithFrame:iconImageFrame];
    iconNumStr = @"23.jpg";
    iconImageView.image = [UIImage imageNamed:iconNumStr];
    [bgCarSelect addSubview:iconImageView];
   // [iconImageView release];

   // UIButton* selectCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[selectCarBtn addTarget:self action:@selector(changebgdown:) forControlEvents:UIControlEventTouchDown];
    [selectCarBtn setBackgroundImage:[UIImage imageNamed:@"ic_more_item_default.png"] forState:UIControlStateNormal];
    [selectCarBtn setBackgroundImage:[UIImage imageNamed:@"set_middle_p.png"] forState:UIControlStateHighlighted];
    
    [selectCarBtn addTarget:self action:@selector(selectCar:) forControlEvents:UIControlEventTouchUpInside];
    
    [selectCarBtn setFrame:CGRectMake(20, -5, 280, 80)];
    
    
    
    iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 18, 56, 42)];
    iconNumStr = @"23.jpg";
    iconImageView.image = [UIImage imageNamed:iconNumStr];
    
    selectIconLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 210, 40)];
    [selectIconLabel setBackgroundColor:[UIColor clearColor]];
    selectIconLabel.text = @"选择汽车品牌";//要修改
    selectIconLabel.backgroundColor = [UIColor clearColor];
    selectIconLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    selectIconLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
    

    UIImageView* btn_arrow = [[UIImageView alloc] initWithFrame:CGRectMake(240, 26, 18, 28)];

    btn_arrow.image = [UIImage imageNamed:@"ic_arrow.png"];
    
    [selectCarBtn addSubview:iconImageView];
    [selectCarBtn addSubview:selectIconLabel];
    [selectCarBtn addSubview:btn_arrow];
    [self.homeBgView addSubview: selectCarBtn];
    
    /////////////////////////////////////////////////
    
    //车牌号:
    UILabel* carNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 11, 150, 40)];
    carNumberLabel.text = @"车牌号 : 豫";
    carNumberLabel.backgroundColor = [UIColor clearColor];
    carNumberLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    carNumberLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
    //    [self.view addSubview:carNumberLabel];
    //    [carNumberLabel release];
    //20, -5, 280, 80
    CGRect bgFrameCarNumber = CGRectMake(20, 73, 280, 80);
    UIImageView* bgCarNumber = [[UIImageView alloc] initWithFrame:bgFrameCarNumber];
    bgCarNumber.image = [UIImage imageNamed:@"middle.png"];
    bgCarNumber.userInteractionEnabled = YES;
    [bgCarNumber addSubview:carNumberField];
    [bgCarNumber addSubview:carNumberLabel];
   // [homeBg addSubview:bgCarNumber];
   // [self.view addSubview:bgCarNumber];
    [self.homeBgView addSubview:bgCarNumber];
   // [bgCarNumber release];
    
    [carNumberLabel release];
    
    //homeBg也要进行dealloc,记着
    
    //车驾号:
    UILabel* carJaLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 280, 40)];
    carJaLabel.text= @"车驾号 :  ";
    carJaLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    carJaLabel.backgroundColor = [UIColor clearColor];
    carJaLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    UIButton *carJaButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 12, 30, 30)];
    [carJaButton setBackgroundImage:[UIImage imageNamed:@"tishi.png"] forState:UIControlStateNormal];
    [carJaButton addTarget:self action:@selector(tiShi) forControlEvents:UIControlEventTouchUpInside];
    //20, 73, 280, 80
    CGRect bgFrameCarJa = CGRectMake(20, 130, 280, 80);
    
    UIImageView* bgCarJa = [[UIImageView alloc] initWithFrame:bgFrameCarJa];
    bgCarJa.image = [UIImage imageNamed:@"ic_more_item_bottom.png"];
    bgCarJa.userInteractionEnabled = YES;
    [bgCarJa addSubview:carJaField];
    [bgCarJa addSubview:carJaLabel];
    //[self.view addSubview:carJaLabel];
    [carJaLabel release];
    [bgCarJa addSubview:carJaButton];
    [carJaButton release];
   // [homeBg addSubview:bgCarJa];
   // [self.view addSubview:bgCarJa];
    [self.homeBgView addSubview:bgCarJa];
    [bgCarJa release];
    
    
    //开始查询按纽
    UIButton* searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchCarInfo:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"btn_normal.png"] forState:UIControlStateNormal];
   
    [searchBtn setTitle:@"开始查询" forState:UIControlStateNormal];
    
    searchBtn.titleLabel.font = [UIFont fontWithName:@"华文楷体" size:18];
   
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    searchBtn.titleLabel 
    searchBtn.frame = CGRectMake(20, 240, 280, 50);
   // [homeBg addSubview:searchBtn];
   // [self.view addSubview:searchBtn];
    [self.homeBgView addSubview:searchBtn];
   // [searchBtn release];
    
    
    
    
    //如果为第一次进入程序，就加载介绍页面
    NSLog(@"c===%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]);
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [self theAppFirstStartView];
    }
}
-(void)tiShi{
    
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationDuration:0.5f];
    // show = YES;
    if(show){
        xingshizhengView.frame = CGRectMake(10, 100, 300, 220);
        xingshi.frame = CGRectMake(0,0,300,220);
        show = NO;
        tiShi_shade.hidden = NO;
    }else{
        xingshizhengView.frame = CGRectMake(320,100,0,0);
        xingshi.frame = CGRectMake(0,0,0,0);
        show = YES;
        tiShi_shade.hidden = YES;
    }
    [UIView commitAnimations];

}
-(void)managerCars:(id)sender{
    managerCars = [[carCommon alloc] initWithNibName:@"carCommon" bundle:nil];
    [self.navigationController pushViewController:managerCars animated:YES];
    
}
-(void)login:(id)sender{
    
    NSLog(@"isLogin = %d",[CarManager sharedInstance].isLogin);
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLogin"])//如果已经login
    {
        userViewController = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:nil];
        [self.navigationController pushViewController:userViewController animated:YES];
    }else
    {
        loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    [self aboutSet:self];
}
//要进行做判断
-(void)remind:(id)sender{
    remindViewController = [[RemindViewController alloc] initWithNibName:@"RemindViewController" bundle:nil];
    [self.navigationController pushViewController:remindViewController animated:YES];
    [self aboutSet:self];
}
-(void)aboutUS:(id)sender{
    aboutUSViewController = [[AboutUSViewController alloc] initWithNibName:@"AboutUSViewController" bundle:nil];
    [self.navigationController pushViewController:aboutUSViewController animated:YES];
    [self aboutSet:self];
}
-(IBAction)aboutSet:(id)sender{
    CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationDuration:0.5f];
   // show = YES;
    if(show){
        rightView.frame = CGRectMake(320-120, 0, 120, screenHeight);
        show = NO;
        btn_shade.hidden = NO;
    }else{
        rightView.frame = CGRectMake(320, 0, 120, screenHeight);
        show = YES;
        btn_shade.hidden = YES;
    }
    [UIView commitAnimations];
}


//进行转递---带参数
-(void)searchCarInfo:(id)sender{
   // selectIconLabel.text = @"选择汽车品牌";//要修改
    //UITextField* carNumberField;//车牌号
    //UITextField* carJaField;//车驾号
    int carJiaLength = [self.carJaField.text length];
 //   NSLog(@"carJiaLength = %d", carJiaLength);
    
    if( (carJiaLength == 6) && (![self.selectIconLabel.text isEqualToString:@"选择汽车品牌"]) )
    {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"亲,请稍等";
    [HUD showAnimated:YES whileExecutingBlock:^{
        
    
    //保守数据－－－车牌号－－－车驾号---车标图片－－－车名称
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:CARLISTFILEPATH]){
        [fileManage createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
    }
    //还要保存其它数据,添加一个字段
    NSDictionary* carDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.carNumberField.text,@"carNum",
                             self.carJaField.text, @"carJiaNum",
                             self.iconNumStr,@"carImageNum",
                             self.selectIconLabel.text, @"carImage",
                             @"NO",@"isRemind",
                             nil];
    
//    [[CarManager sharedInstance].carsArr addObject:carDict];


    NSArray* fileArr = [NSArray arrayWithContentsOfFile:CARLISTFILEPATH];
    [CarManager sharedInstance].carsArr = [NSMutableArray arrayWithArray:fileArr];
    int numOfCar = [fileArr count];
    NSLog(@"numOfCar = %d",numOfCar);
    if(numOfCar == 0){
        [[CarManager sharedInstance].carsArr addObject:carDict];
        [[CarManager sharedInstance].carsArr writeToFile:CARLISTFILEPATH atomically:YES];
    }else
    {
    NSMutableArray* tempArr=[[NSMutableArray alloc] init];
    for(int i = 0; i < numOfCar; i++)
    {
        NSDictionary* tempDic = [fileArr objectAtIndex:i];
        NSString* mutableArr = [tempDic objectForKey:@"carNum"];
        
        [tempArr addObject:mutableArr];
        NSLog(@"tempArr = %@",tempArr);

    }
        
        NSLog(@"self.carNumberField.text = %@",self.carNumberField.text);
        NSLog(@"tempArr = %@",tempArr);
    if([tempArr containsObject:self.carNumberField.text]){
        //do nothing
        NSLog(@"已经存在");
    }else
    {
        [[CarManager sharedInstance].carsArr addObject:carDict];
        [[CarManager sharedInstance].carsArr writeToFile:CARLISTFILEPATH atomically:YES];
    }
        [tempArr release];
    
    }
        sleep(8);
    }completionBlock:^{
        carInfoListViewController = [[CarInfoListViewController alloc] initWithNibName:@"CarInfoListViewController" bundle:nil];
       [carInfoListViewController carDataNumber:carNumberField.text carJaNumber:carJaField.text];
        
       
        carInfoListViewController.carName = [self.carNumberField.text uppercaseString];
        NSLog(@"whichCarLabel = %@", carInfoListViewController.carName);
        /*
        carInfoListViewController.whichCarLabel.text = carNumberField.text;
        NSLog(@"whichCarLabel = %@", carInfoListViewController.whichCarLabel);//null
        NSLog(@"myTest=%@",carNumberField.text);
        NSLog(@"carInfoListViewController.whichCarLabel.text = %@", carInfoListViewController.whichCarLabel.text);//null
        */
        [self.navigationController pushViewController:carInfoListViewController animated:YES];
        
        
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }];
    }else{//输入的车驾号不等于6位
        if(carJiaLength != 6){
        UIAlertView* myAlert = [[UIAlertView alloc] initWithTitle:@"亲,输入不对哦!"
                                                          message:@"输入的车驾号不是6位哦!"
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil];
        [myAlert show];
            [myAlert release];}
        else{
            UIAlertView* nextAlert = [[UIAlertView alloc] initWithTitle:@"亲,输入不对哦!"
                                                                message:@"亲,请选择汽车品牌!"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"好的!", nil];
            [nextAlert show];
            [nextAlert release];
        }
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    
    NSCharacterSet *cs;
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
   // NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    BOOL basicTest = [string isEqualToString:filtered];
    
    if (carJaField== textField )
    {
        if ([toBeString length] > 6 ) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"请输入车驾号后六位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];
            [alert show];
            return NO;
        }
    }
    if (carNumberField==textField) {
        if ([toBeString length] > 6) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"请输入车牌号" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];
            [alert show];
            return NO;
        }
        
    }
    return YES;
}

//100, 20, 210, 40
-(UITextField*)getTextFieldNormal:(NSString *)placeMsg{
    CGRect frame = CGRectMake(100, 20, 220, 25);
    UITextField* textFieldNormal = [[[UITextField alloc] initWithFrame:frame] autorelease];
   // textFieldNormal.backgroundColor = [UIColor clearColor];
    textFieldNormal.borderStyle = UITextBorderStyleNone;
    textFieldNormal.textColor = [UIColor blackColor];
    textFieldNormal.font = [UIFont systemFontOfSize:18.0];
    textFieldNormal.placeholder = placeMsg;
    textFieldNormal.backgroundColor = [UIColor clearColor];
    textFieldNormal.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
    textFieldNormal.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
    textFieldNormal.returnKeyType = UIReturnKeyDone;
    
//    textFieldNormal.delegate = self;
    
   // textFieldNormal.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
 //   textFieldNormal.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	return textFieldNormal;
}

//添加手势,让键盘消失
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
   
        [carNumberField resignFirstResponder];
        
        [carJaField resignFirstResponder];
}

-(void)selectCar:(id)sender{
    carViewController = [[CarViewController alloc] initWithNibName:@"CarViewController" bundle:nil];
    carViewController.delegate = self;
    [self.navigationController pushViewController:carViewController animated:YES];
}

//添加程序第一次启动时介绍页面视图
-(void)theAppFirstStartView{
     CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    UIView* firstShowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight-20)];
    firstShowView.backgroundColor = [UIColor blackColor];
    firstShowView.tag = 18;
    [self.view addSubview:firstShowView];
    [firstShowView release];
    
    UIScrollView* scrollViewInFirstView = [[UIScrollView alloc] initWithFrame:firstShowView.bounds];
    scrollViewInFirstView.backgroundColor = [UIColor clearColor];
    scrollViewInFirstView.contentSize = CGSizeMake(320*2, screenHeight-20);
    scrollViewInFirstView.showsVerticalScrollIndicator = NO;
    scrollViewInFirstView.showsHorizontalScrollIndicator = NO;
    scrollViewInFirstView.pagingEnabled = YES;
    scrollViewInFirstView.bounces = YES;
    scrollViewInFirstView.delegate = self;
    scrollViewInFirstView.tag = 10000;
    [firstShowView addSubview:scrollViewInFirstView];
    [scrollViewInFirstView release];
    
    for (int i = 1; i < 3; i++){
        NSString* string = [NSString stringWithFormat:@"yindao%i",i];
        NSString* introduceFile = [[NSBundle mainBundle] pathForResource:string ofType:@"png"];
        UIImage* introduceImage = [UIImage imageWithContentsOfFile:introduceFile];
        UIImageView* introduceImageView = [[UIImageView alloc] initWithImage:introduceImage];
        introduceImageView.frame = CGRectMake(320*(i-1), 0, 320, screenHeight-20);
        [scrollViewInFirstView addSubview:introduceImageView];
        [introduceImageView release];
        
    }
    //主页按纽262 × 158 pixels
    UIButton* startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    startBtn.frame = CGRectMake(35+320, 300, 262, 80);
    startBtn.frame = CGRectMake(100+320, 320, 131, 80);
    [startBtn setImage:[UIImage imageNamed:@"ljsy_n.png"] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startTheApp) forControlEvents:UIControlEventTouchUpInside];
    [scrollViewInFirstView addSubview:startBtn];
    
    pageForFirstView = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 440, 320, 10)];
    pageForFirstView.numberOfPages = 2;
    [firstShowView addSubview:pageForFirstView];
    
    //[super viewDidLoad];
}
//启动程序就是删除介绍页面

-(void)startTheApp{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];
    [[self.view viewWithTag:18] removeFromSuperview];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
	[UIView commitAnimations];
}
// 用于存储上一次scrollView.contentOffset的值
int xContentOffsetLastTime = 0;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollView");
    if ([scrollView viewWithTag:10000]) {
        int curPage = scrollView.contentOffset.x / scrollView.frame.size.width;
        pageForFirstView.currentPage = curPage;
        if (scrollView.contentOffset.x > xContentOffsetLastTime) {
            // 向右滑动
            NSLog(@"向右滑动");
            xContentOffsetLastTime = scrollView.contentOffset.x ;
        }
        else if (scrollView.contentOffset.x < xContentOffsetLastTime ){
            // 向左滑动
            NSLog(@"向左滑动");
            xContentOffsetLastTime = scrollView.contentOffset.x ;
        }
        else {
            if (scrollView.contentOffset.x == 320.0f) {
                [self performSelector:@selector(startTheApp) withObject:nil afterDelay:0.2];
                xContentOffsetLastTime = 0;
            }
            return;
        }
    }else{
        int curPage = scrollView.contentOffset.x / scrollView.frame.size.width;
        pageControl.currentPage = curPage;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [carListArr release];
    [carDataDict release];
    
    [selectIconLabel release];
    
    [super dealloc];
}
#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}

@end
