//
//  CarInfoListViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-10.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "CarInfoListViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "CarInfo.h"
#import "HomeIntroduce.h"
#import "IndexViewController.h"
#import "RemindViewController.h"

@interface CarInfoListViewController ()

@end

@implementation CarInfoListViewController
@synthesize mainTabView, data, weifaArr;
@synthesize delegate;
@synthesize whichCarLabel, homeManyLabel, countMoneyLabel;
@synthesize carName;

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
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	leftButton.frame = CGRectMake(5,8, 50, 30);
	[leftButton setTitle:@"返回" forState:UIControlStateNormal];
	leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    leftButton.titleLabel.textColor = [UIColor whiteColor];
    leftButton.titleLabel.shadowOffset = CGSizeMake(-1.0f, 2.0f);
    leftButton.titleLabel.shadowColor = [UIColor blackColor];
	[leftButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 5)];
	[leftButton setBackgroundImage:[UIImage imageNamed:@"btn_setting.png"] forState:UIControlStateNormal];
	[leftButton addTarget:self action:@selector(backTopage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    ////////////////////////////////////////////////////////////////////

   
    //单元格的行高
    self.mainTabView.rowHeight = 210;
    
    //违法行为
   // self.weifaArr = [[NSArray alloc] initWithArray:[self weifaData]];
    self.weifaArr = [[NSArray alloc] initWithArray:[self weifaDB]];

    [self.mainTabView reloadData];
  
}
- (void)backTopage{
    IndexViewController* indexViewController=[[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
}
/*
//违法行为
-(NSArray*)weifaData{
    NSString* file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"wfxw"] ofType:@"txt"];
    NSString* fileData = [[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    //  NSLog(@"fileData = %@", fileData);
    NSArray* records = [fileData componentsSeparatedByString:@"\n"];
    NSMutableDictionary* tmpdic = [NSMutableDictionary dictionaryWithCapacity:[records count]];
    
    NSMutableDictionary* tmpdic1 = [NSMutableDictionary dictionaryWithCapacity:[records count]];
    
    //得到第一个数据
    NSMutableArray* firstArr = [NSMutableArray arrayWithObjects: nil];
    
    for(NSString* record in records)
    {
        NSArray* arr = [record componentsSeparatedByString:@";"];
        
        [firstArr addObject:[arr objectAtIndex:0]];
        //第一个数据
        [tmpdic setValue:[[arr objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:[arr objectAtIndex:0]];
        //第二个数据
        [tmpdic1 setValue:[[arr objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:[arr objectAtIndex:0]];
        
        [[arr objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
    }
    
    NSArray* returnArr = [NSMutableArray arrayWithObjects:firstArr, tmpdic, tmpdic1, nil];
    return returnArr;
    
}*/
-(NSArray*)weifaDB{
    NSString* file = [[NSBundle mainBundle] pathForResource:@"weifa" ofType:@"txt"];
    NSString* fileDB = [[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* dic = [fileDB objectFromJSONString];
    return dic;  
}

-(void)carDataNumber:(NSString*)numberStr carJaNumber:(NSString*)carJaStr{
    NSString* urlString = [NSString stringWithFormat:@"http://116.255.238.8:3000/querytraffic"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    //设置需要POST的数据,这里提交两个数据
    NSString* strA = @"豫";
    strA = [strA stringByAppendingString:numberStr];
    [requestForm setPostValue:strA forKey:@"hphm"];
    [requestForm setPostValue:carJaStr forKey:@"clsbdh"];
    [requestForm setPostValue:@"0" forKey:@"cxlb"];
    
    
       // [requestForm setPostValue:@"豫AGM979" forKey:@"hphm"];
      //   [requestForm setPostValue:@"428163" forKey:@"clsbdh"];
    [requestForm setPostValue:@"02" forKey:@"hpzl"];
    [requestForm setPostValue:@"VS" forKey:@"queryid"];
    // 设定委托，委托自己实现异步请求方法
    [requestForm setDelegate:self];
    [requestForm setDidFinishSelector:@selector(requestDone:)];
    [requestForm setDidFailSelector:@selector(requestWentWrong:)];
    // 开始异步请求
    [requestForm startAsynchronous];

}
// 请求结束，获取 Response 数据
-(void)requestDone:(ASIHTTPRequest*)request{
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding]);
    NSString* requestStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary* requests = [requestStr objectFromJSONString];
    NSLog(@"%@",[request class]);//JKDictionary
    

    //做逻辑处理
    if(([requests objectForKey:@"root"] != NULL)&&([[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo"] != NULL)){
    NSArray* carArrays = [[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"];
    NSNumber* countArr = [[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo"] objectForKey:@"count"];
    NSLog(@"countArr = %@", countArr);
    NSLog(@"countArr = %@", [countArr class]);
    //违法次数
    NSString* homeManyStr = [NSString stringWithFormat:@"%@", countArr];
    self.homeManyLabel.text = homeManyStr;
    NSLog(@"self.homeManyLabel.text = %@",self.homeManyLabel.text);

   
    self.data = carArrays;
    
    /////////////////////////////////////////
    //总共罚款数//这个地方数据不对
    int count = [self.data count];
    
    countDic = [[NSMutableDictionary alloc] init];
    int allMoney = 0;
    for(int i = 0; i < count; i++){
        countDic = [self.data objectAtIndex:i];
        NSNumber* tempNum = [countDic objectForKey:@"fkje"];
        allMoney += [tempNum intValue];
    }
    
    self.countMoneyLabel.text = [NSString stringWithFormat:@"%d",allMoney];
    
    self.whichCarLabel.text = self.carName;
    
 
    [self.mainTabView reloadData];
    }
}
// 请求失败，获取 error
-(void)requestWentWrong:(ASIHTTPRequest*)request{
    NSError* error = [request error];
    NSLog(@"%@", error.userInfo);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.data count];
    //return 1;
}
//要改
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    carInfo = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!carInfo){
        carInfo = [[[NSBundle mainBundle] loadNibNamed:@"CarInfo" owner:self options:nil] lastObject];
    }
    

    NSDictionary* dic1;
    if([self.data count] == 1)
    {
        if([[[self.data objectAtIndex:0] objectForKey:@"jkbj"] integerValue] == 0){
            carInfo.jiaokuanStatusLabel.text = @"未缴款";
        }else if([[[self.data objectAtIndex:0] objectForKey:@"jkbj"] integerValue] == 1){
            carInfo.jiaokuanStatusLabel.text = @"已缴款";
        }else carInfo.jiaokuanStatusLabel.text = @"无需缴款";
        
        if([[[self.data objectAtIndex:0] objectForKey:@"clbj"] integerValue] == 0){
            
            carInfo.caijueStatusLabel.text = @"未裁决";
        }else if([[[self.data objectAtIndex:0] objectForKey:@"clbj"] integerValue] == 1){
            
            carInfo.caijueStatusLabel.text = @"已裁决";
        }else carInfo.caijueStatusLabel.text = @"其它";
        
    }else{
        dic1 = [self.data objectAtIndex:indexPath.row];
    }
      
    NSNumber* FirstNumber = [dic1 objectForKey:@"wfxw"];
    NSString* FirstNumberStr = [NSString stringWithFormat:@"%@",FirstNumber];
    int num = [self.weifaArr count];
    NSString* tempStr = nil;
    for(int i = 0; i < num; i++)
    {
        tempStr = [[self.weifaArr objectAtIndex:i] objectForKey:@"wfxw"];
        if([[dic1 objectForKey:@"clbj"]integerValue] == 0)
        {
        if([FirstNumberStr isEqualToString:tempStr])
        {
            
//            n = [carInfo setlablefont:carInfo.whyLabel gettext:[[self.weifaArr objectAtIndex:i] objectForKey:@"wfms"]];
//            carInfo.fakuanLabel.center=CGPointMake(carInfo.fakuanLabel.center.x, carInfo.fakuanLabel.center.y+n);

            carInfo.whyLabel.text = [[self.weifaArr objectAtIndex:i] objectForKey:@"wfms"];
            
            NSMutableString* tempkf = [[NSMutableString alloc] initWithString:[[self.weifaArr objectAtIndex:i] objectForKey:@"wfjf"]];
            [tempkf appendString:@"(参考值，具体以裁决为准)"];
            carInfo.koufenLabel.text = tempkf;//扣分
            //自动折行设置
            carInfo.whyLabel.lineBreakMode = UILineBreakModeWordWrap;
            carInfo.whyLabel.numberOfLines = 4;
            
            NSMutableString* tempfk = [[NSMutableString alloc] initWithString:[[self.weifaArr objectAtIndex:i] objectForKey:@"fkje"]];
            [tempfk appendString:@"(参考值，具体以裁决为准)"];
//            carInfo.koufenLabel.text = [[self.weifaArr objectAtIndex:i] objectForKey:@"wfjf"];//扣分
            carInfo.fakuanLabel.text = tempfk;
//           carInfo.fakuanLabel.text = [[self.weifaArr objectAtIndex:i] objectForKey:@"fkje"];//罚款
            carInfo.jiaokuanStatusLabel.text = @"未缴款";
            carInfo.caijueStatusLabel.text = @"未裁决";
            
            break;//是否执行
        }
        }else if([[dic1 objectForKey:@"clbj"] integerValue] == 1){
            if([FirstNumberStr isEqualToString:tempStr])
            {
                carInfo.whyLabel.text = [[self.weifaArr objectAtIndex:i] objectForKey:@"wfms"];
                carInfo.koufenLabel.text = [[self.weifaArr objectAtIndex:i] objectForKey:@"wfjf"];
               
                //不替换违法的罚款金额
                NSNumber* fkje = [dic1 objectForKey:@"fkje"];
                carInfo.fakuanLabel.text = [NSString stringWithFormat:@"%@", fkje];
                
                break;//是否执行
            }
        }
    }

    NSString* wfsj = [dic1 objectForKey:@"wfsj"];//违法时间
    carInfo.whenLabel.text = wfsj;    
    NSString* wfdz = [dic1 objectForKey:@"wfdz"];//违法地点
    carInfo.whereLabel.text = wfdz;
    
    carInfo.frame = CGRectMake(0, 0, carInfo.frame.size.width, carInfo.frame.size.height+n);
    return carInfo;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    n=0.0;
    return cell.frame.size.height;
}
//在此进行逻辑判断
-(IBAction)remindBtn:(id)sender{
    remindViewController = [[RemindViewController alloc] initWithNibName:@"RemindViewController" bundle:nil];
    [self.navigationController pushViewController:remindViewController animated:YES];
}

-(void)dealloc{
    [data release];
    [weifaArr release];
    [countDic release];
    [super dealloc];
}


@end
