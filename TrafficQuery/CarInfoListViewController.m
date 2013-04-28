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

#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]

@interface CarInfoListViewController ()

@end

@implementation CarInfoListViewController
@synthesize mainTabView, data, weifaArr;
@synthesize delegate;
@synthesize whichCarLabel, homeManyLabel, countMoneyLabel;
@synthesize carName;
@synthesize myDicData;

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
	leftButton.frame = CGRectMake(5,6, 50, 30);
    /*
	[leftButton setTitle:@"返回" forState:UIControlStateNormal];
	leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    leftButton.titleLabel.textColor = [UIColor whiteColor];
    leftButton.titleLabel.shadowOffset = CGSizeMake(-1.0f, 2.0f);
    leftButton.titleLabel.shadowColor = [UIColor blackColor];
	[leftButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 5)];*/
	[leftButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
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
//    [requestForm setPostValue:@"2013-02-01" forKey:@"date_s"];
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
/*
 {"root":{"head":{"code":1,"message":"Success"},"VehSurveilInfo":{"count":1,"msg":"号牌种类-02号牌号码-豫A222FX,查询类别-未缴款,违法时间从:2013-02-01到2013-04-27,共1条非现场违法","surveil":
 
 {"cjjgmc":"电子警察采集三单位","wfsj":"2013-03-04 08:51","wfdz":"农业路（丰庆路-天明路）","wfxw":1018,"clbj":0,"cljgmc":"null","jkbj":0,"jkrq":"null","fkje":0,"jllx":"新增"}
 
 }
 }}
 */
/*
 {"root":{"head":{"code":1,"message":"Success"},"VehSurveilInfo":{"count":2,"msg":"号牌种类-02号牌号码-豫A222FX,查询类别-未缴款,违法时间从:2011-04-27到2013-04-27,共2条非现场违法","surveil":
 
 
 [
 {"cjjgmc":"高速支队三大队","wfsj":"2013-01-01 11:18","wfdz":"大广高速1860公里200米","wfxw":1352,"clbj":0,"cljgmc":"null","jkbj":0,"jkrq":"null","fkje":200,"jllx":"新增"},
 {"cjjgmc":"电子警察采集三单位","wfsj":"2013-03-04 08:51","wfdz":"农业路（丰庆路-天明路）","wfxw":1018,"clbj":0,"cljgmc":"null","jkbj":0,"jkrq":"null","fkje":0,"jllx":"新增"}
 ]
 
 
 }}}
 */
-(void)requestDone:(ASIHTTPRequest*)request{
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding]);
    NSString* requestStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary* requests = [requestStr objectFromJSONString];
    NSLog(@"requestClass = %@",[requests class]);//JKDictionary
    
    
    if (![[[[requests objectForKey:@"root"] objectForKey:@"head"]objectForKey:@"message"] isEqualToString:@"Success"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"您所查询的信息有误" message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        NSMutableArray * carMutableArray = [NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH];
        [carMutableArray removeLastObject];
        [carMutableArray writeToFile:CARLISTFILEPATH atomically:YES];
        
        
    }
    

    //做逻辑处理
    if(([requests objectForKey:@"root"] != NULL)&&([[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo"] != NULL))
    {
        
    
    countArr = [[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo"] objectForKey:@"count"];
        //只有一条违法记录
    if([countArr integerValue] == 1)
    {
        NSDictionary* myCarDic = [[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"];
        self.myDicData = myCarDic;
        NSLog(@"在些=  %d",[self.data count]);
        //违法次数
        NSString* homeManyStr = [NSString stringWithFormat:@"%@", countArr];
        self.homeManyLabel.text = homeManyStr;
        //哪辆车违法
        self.whichCarLabel.text = self.carName;
        //总共罚款数
        //未裁决
        if([[[[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"] objectForKey:@"clbj"] integerValue ] == 0){
            int  wfxw = [[[[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo"] objectForKey:@"surveil"] objectForKey:@"wfxw"] integerValue];
            NSLog(@"wfxw = %d", wfxw);
            
            int num = [self.weifaArr count];
            int tempStr;
            for(int i = 0; i < num; i++)
            {
                tempStr = [[[self.weifaArr objectAtIndex:i] objectForKey:@"wfxw"] integerValue];
               // NSLog(@"tempStr = %d",tempStr);
                
                if(wfxw == tempStr){
                    self.countMoneyLabel.text = [[self.weifaArr objectAtIndex:i] objectForKey:@"fkje"];
                    [self.mainTabView reloadData];
                    break;
                }
            }
            
        }
        
    }
    
    else
    {//多条记录

     NSArray* carArrays = [[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"];
        
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
    //有一条记录的，在此报错
    //在此做判断,
        
        
    for(int i = 0; i < count; i++)
      {
       
        countDic = [self.data objectAtIndex:i];
          if([[countDic objectForKey:@"clbj"] integerValue] == 0)
          {//示裁决
              //去查表---
              int num = [self.weifaArr count];
              int tempStr;
              for(int i = 0; i < num; i++)
              {
                  tempStr = [[[self.weifaArr objectAtIndex:i] objectForKey:@"wfxw"] integerValue];
                  if([[countDic objectForKey:@"wfxw"] integerValue] == tempStr)
                  {
                      int  tempNum = [[[self.weifaArr objectAtIndex:i] objectForKey:@"fkje"] integerValue];
                      allMoney += tempNum;
                      break;
                  }
              }
          }else{
              NSNumber* otherNum = [countDic objectForKey:@"fkje"];
              allMoney += [otherNum intValue];
          }
          


      }
    
    self.countMoneyLabel.text = [NSString stringWithFormat:@"%d",allMoney];
    
    self.whichCarLabel.text = self.carName;
    [self.mainTabView reloadData];
    }
       
  }
    
}
// 请求失败，获取 error
-(void)requestWentWrong:(ASIHTTPRequest*)request{
    
    NSError* error = [request error];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"数据加载失败" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    NSLog(@"%@", error.userInfo);
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self backTopage];
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
    if([countArr integerValue] == 1){
        return 1;
    }else{
        return [self.data count];}
   
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
    int num = [self.weifaArr count];
    //如果只有一条记录
//    if([self.data count] == 1)
   
 //   NSLog(@"countArr = %d",[countArr integerValue]);
    if([countArr integerValue] == 1)
    {
         NSLog(@"self.data = %@",self.myDicData);
        NSString* tempStr = nil;
        if([[self.myDicData objectForKey:@"jkbj"] integerValue] == 0){
            carInfo.jiaokuanStatusLabel.text = @"未缴款";
        }else if([[self.myDicData objectForKey:@"jkbj"] integerValue] == 1){
            carInfo.jiaokuanStatusLabel.text = @"已缴款";
        }else{
            carInfo.jiaokuanStatusLabel.text = @"无需缴款";
        }
        if([[self.myDicData objectForKey:@"clbj"] integerValue] == 0 )
        {
            carInfo.caijueStatusLabel.text = @"未裁决";
            int wfxwNum = [[self.myDicData objectForKey:@"wfxw"] integerValue];
            for (int i = 0; i < num; i++)
            {
                tempStr = [[self.weifaArr objectAtIndex:i] objectForKey:@"wfxw"];
                if(wfxwNum == [tempStr integerValue])
                {
                    NSMutableString* tempfk = [[NSMutableString alloc] initWithString:[[self.weifaArr objectAtIndex:i] objectForKey:@"fkje"]];
                    [tempfk appendString:@"(参考值，具体以裁决为准)"];
                    carInfo.fakuanLabel.text = tempfk;
                    NSMutableString* tempkf = [[NSMutableString alloc] initWithString:[[self.weifaArr objectAtIndex:i] objectForKey:@"wfjf"]];
                    [tempkf appendString:@"(参考值，具体以裁决为准)"];
                    carInfo.koufenLabel.text = tempkf;
                    carInfo.whyLabel.text = [[self.weifaArr objectAtIndex:i] objectForKey:@"wfms"];
                    carInfo.whenLabel.text = [self.myDicData objectForKey:@"wfsj"];
                    carInfo.whereLabel.text = [self.myDicData objectForKey:@"wfdz"];
                    
                }
            }
            
            
        }else if([[self.myDicData objectForKey:@"clbj"] integerValue] == 1){
            carInfo.caijueStatusLabel.text = @"已裁决";//没写完
        }else{
            carInfo.caijueStatusLabel.text = @"其它";
        }
        
    }
    
    else{
    
    dic1 = [self.data objectAtIndex:indexPath.row];
      
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
            
            n = [carInfo setlablefont:carInfo.whyLabel gettext:[[self.weifaArr objectAtIndex:i] objectForKey:@"wfms"]];
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
        }else if([[dic1 objectForKey:@"clbj"] integerValue] == 1)
        {
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
    }
    if (n>0.0) {
        UILabel *lable2=(UILabel *)[carInfo viewWithTag:2];
                lable2.center=CGPointMake(lable2.center.x, lable2.center.y-7);
            for (int i=3; i<=10; i++) {
        UILabel *lable=(UILabel *)[carInfo viewWithTag:i];
        lable.center=CGPointMake(lable.center.x, lable.center.y+n);
                
                
    }
    }
    UILabel *lable1=(UILabel *)[carInfo viewWithTag:2];
    lable1.center=CGPointMake(lable1.center.x, lable1.center.y+4);

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
