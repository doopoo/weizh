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
#import "CarManager.h"
#import "LoginViewController.h"
#import "IndexViewController.h"
#import "VIPViewController.h"

#import "JSONKit.h"
#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]
#define USERFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/User.plist"]

@interface RemindViewController ()

@end

@implementation RemindViewController
@synthesize carDictionary, carMutableArray, mainTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)remind:(UIButton *)sender
{
//    int m;
    
//    UIButton* myBtn = (UIButton*)sender;
    myBtn = (UIButton*)sender;

    m=myBtn.tag;
    NSLog(@"%i~~%i",m,n);
    //n--哪一行
  //  if (!myBtn.selected==YES)
    //这个是关着的状态
    /*
     判断是否login，再判断是什么样的用户，先进行转场
     */
    
    ///////////////////////////////////////////////////////
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/add/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.carMutableArray objectAtIndex:m - 100];
    NSString* plate = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carImage"];
    NSString* vin = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carJiaNum"];
    NSString* imgName = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carImageNum"];
    NSString* brand = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carNum"];
    [requestForm setPostValue:plate forKey:@"plate"];
    [requestForm setPostValue:vin forKey:@"vin"];
    [requestForm setPostValue:imgName forKey:@"imgName"];
    [requestForm setPostValue:brand forKey:@"brand"];
    [requestForm startSynchronous];
    [CarManager sharedInstance].orderId = [NSString stringWithFormat:@"%@",[[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]];
    NSLog(@"orderId ============%@",[[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]);
    //////////////////////////////////////////////
    
    
        NSDictionary* dataDic = [loginStr objectFromJSONString];
        NSLog(@"dataDic = %@", dataDic);
        //登陆成功
        if(myBtn.selected == NO){
            if([[dataDic objectForKey:@"status"] isEqualToString:@"8000"])
            {
                if([[userDic objectForKey:@"flag"] isEqualToString:@"1"])
                {//付费用户
                    NSString* payType = [userDic objectForKey:@"payType"];
                    NSString* status = [userDic objectForKey:@"status"];
                    //-  NSString* endTime = [userDic objectForKey:@"end"];
                    
                    if([payType isEqualToString:@"2"])
                    {//短信付费
                        if([status isEqualToString:@"1"])
                        {//确定是会员
                            //进行绑定车辆
                            [self vipAddCar];
                        }else if([status isEqualToString:@"0"])
                        {//不确定是会员，需判断时间
                            //这个自己再写
                            NSLog(@"调用我了");
                                 [self vipAddCar];//这个好你不对
                        }
                    }else if([payType isEqualToString:@"1"])
                    {//支付宝付费
                        //进行绑定车辆
                        [self vipAddCar];
                        //////////////////////////////

                        NSLog(@"是否发生了调用");
                    }
                }else
                {
                    //不是付费用户，进行转场===进入指引页面
                    [self noVip];
                }
                
            }else{//login成功串不存在
                //没有login--
                NSLog(@"登陆不成功login");
                loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [self.navigationController pushViewController:loginViewController animated:YES];
            }
            
        }else{//myBtn.selected == YES
            NSLog(@"调用了myBtn.selected == YES");//进行删除操作
            if([[dataDic objectForKey:@"status"] isEqualToString:@"8000"])
            {
                if([[userDic objectForKey:@"flag"] isEqualToString:@"1"])
                {//付费用户
                    NSString* payType = [userDic objectForKey:@"payType"];
                    NSString* status = [userDic objectForKey:@"status"];
                    //-  NSString* endTime = [userDic objectForKey:@"end"];
                    
                    if([payType isEqualToString:@"2"])
                    {//短信付费
                        if([status isEqualToString:@"1"])
                        {//确定是会员
                            //进行绑定车辆
                            [self vipDelCar];
                        }else if([status isEqualToString:@"0"])
                        {//不确定是会员，需判断时间
                            //这个自己再写
                            NSLog(@"调用我了del");
                            [self vipDelCar];//这个好你不对
                        }
                    }else if([payType isEqualToString:@"1"])
                    {//支付宝付费
                        //进行绑定车辆
                        
                        [self vipDelCar];
                    }
                }else
                {
                    //不是付费用户，进行转场===进入指引页面
                    [self noVip];
                }
                
            }else{//login成功串不存在-----------------------这个好像没有运行
                //没有login
                NSLog(@"登陆不成功login222");
                loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [self.navigationController pushViewController:loginViewController animated:YES];
            }
        }
}


-(void)requestFailed:(ASIHTTPRequest*)request{
    NSLog(@"登陆失败,跳转到登陆页面");
    loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

-(void)noVip{
    NSLog(@"noVip在此");
    NSUserDefaults* loginFile = [NSUserDefaults standardUserDefaults];
    [loginFile removeObjectForKey:@"hasLogin"];
    [loginFile setObject:@"NO" forKey:@"hasLogin"];
    //在这里面作判断,
    //如果已经login，进入引导页面
   // [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLogin"];
    [CarManager sharedInstance].isLogin = YES;/////////////////////////////////////////////////////////////////////
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLogin"];
    vipViewController = [[VIPViewController alloc] initWithNibName:@"VIPViewController" bundle:nil];
    [self.navigationController pushViewController:vipViewController animated:YES];
    
//    
//    loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    [self.navigationController pushViewController:loginViewController animated:YES];
}
//进行绑车，进行按纽的修改,所有的开关都关，只有一个为开着的
//myBtn
-(void)vipAddCar{
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/add/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.carMutableArray objectAtIndex:m - 100];
    NSString* plate = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carImage"];
    NSString* vin = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carJiaNum"];
    NSString* imgName = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carImageNum"];
    NSString* brand = [[self.carMutableArray objectAtIndex:m - 100] objectForKey:@"carNum"];
    [requestForm setPostValue:plate forKey:@"plate"];
    [requestForm setPostValue:vin forKey:@"vin"];
    [requestForm setPostValue:imgName forKey:@"imgName"];
    [requestForm setPostValue:brand forKey:@"brand"];
    [requestForm setDidFinishSelector:@selector(addSuccess:)];
    [requestForm setDidFailSelector:@selector(addFailed:)];
    [requestForm setDelegate:self];
    [requestForm startAsynchronous];

}
-(void)addSuccess:(ASIHTTPRequest*)request{
    loginIsYes=[[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"message"];
    NSLog(@"绑定成功的返回值\n%@",[[[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]);
    
//    [CarManager sharedInstance].orderId = [[[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"];
//    NSLog(@"orderId ============%@",[[[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]);
    if([loginIsYes isEqualToString:@"绑定成功"]){
    
        //这个地方有问题
        for (int j=0; j<=n; j++)
        {
        	UIButton* myBtn1 = (UIButton*)[[[[myBtn superview] superview]superview] viewWithTag:j+100];;
            if(j == m - 100){
                [[self.carMutableArray objectAtIndex:m - 100] setValue:@"YES" forKey:@"isRemind"];
            }else{
                [[self.carMutableArray objectAtIndex:j] setValue:@"NO" forKey:@"isRemind"];
            }
            NSDictionary* tempDic = [self.carMutableArray objectAtIndex:j];
            [self.carMutableArray replaceObjectAtIndex:j withObject:tempDic];
            [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
            myBtn1.selected = NO;
        }
        myBtn.selected = YES;
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"绑定成功" message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        
        NSLog(@"调用了myBtn");
    }


}
-(void)addFailed:(ASIHTTPRequest*)request{
    [request error];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"绑定失败!" message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}




//
-(void)vipDelCar{
    NSString* AddString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/findCarByUser/"];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:AddString]];
    [request startSynchronous];
    
    /*
     {"message":null,"data":null,"status":"8000","list":[{"ucid":95,"userid":20,"plate":"阿斯顿·马丁","vin":"599890","brand":"a03Q37","issend":"1","sendtype":null,"ucaddtime":1366887239000,"imgName":"116.jpg"}]}
     */
    NSLog(@"response===\n%@",[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding]);
    NSString* requestStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary* requestDic = [requestStr objectFromJSONString ];
    NSLog(@"requestDic = %@",requestDic);
 //-   NSLog(@"requestDIc = %d",[[requestDic objectForKey:@"list"] indexOfObject:0]);
    //  NSString* ucidStr = [requestDic objectForKey:@"list"]
    NSDictionary* listDic = [[requestDic objectForKey:@"list"] objectAtIndex:0 ];
    NSString* ucidStr = [listDic objectForKey:@"ucid"];
    NSLog(@"ucidStr = %@",ucidStr);
    
    
    NSString* DelString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/del/"];
    
    ASIFormDataRequest* delRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:DelString]];
    [delRequest setPostValue:ucidStr forKey:@"carId"];
    [delRequest startSynchronous];
    NSLog(@"delString\n%@",[[NSString alloc] initWithData:[delRequest responseData] encoding:NSUTF8StringEncoding]);
    
    NSString* ddString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/findCarByUser/"];
    //    ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:AddString]];
    ASIFormDataRequest* requestnext = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ddString]];
    [requestnext startSynchronous];
    NSLog(@"requestnext\n%@",[[NSString alloc] initWithData:[requestnext responseData] encoding:NSUTF8StringEncoding]);
    
    delSuccess=[[[[NSString alloc] initWithData:[delRequest responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"message"];
    NSLog(@"delSuccess = %@", delSuccess);
    if([delSuccess isEqualToString:@"删除成功"]){
        //这个地方有问题
        for (int j=0; j<=n; j++)
        {
        	UIButton* myBtn1 = (UIButton*)[[[[myBtn superview] superview]superview] viewWithTag:j+100];
//            if(j == m - 100){
//                [[self.carMutableArray objectAtIndex:m - 100] setValue:@"YES" forKey:@"isRemind"];
//            }else{
                [[self.carMutableArray objectAtIndex:j] setValue:@"NO" forKey:@"isRemind"];
//            }
            NSDictionary* tempDic = [self.carMutableArray objectAtIndex:j];
            [self.carMutableArray replaceObjectAtIndex:j withObject:tempDic];
            [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
            myBtn1.selected = NO;
        }

    }
    
    myBtn.selected = NO;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString* AddString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/findCarByUser/"];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:AddString]];
    [request startSynchronous];
    NSFileManager* userFile = [NSFileManager defaultManager];
    if(![userFile fileExistsAtPath:USERFILEPATH]){
        [userFile createFileAtPath:USERFILEPATH contents:nil attributes:nil];
    }
    userDic = [[NSDictionary alloc] initWithContentsOfFile:USERFILEPATH];
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:CARLISTFILEPATH]){
        [fileManage createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
    }
    self.carMutableArray = [NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH];
    NSLog(@"self.carMutableArray = %@", self.carMutableArray);
    
    /*
     {"message":null,"data":null,"status":"8000","list":[{"ucid":95,"userid":20,"plate":"阿斯顿·马丁","vin":"599890","brand":"a03Q37","issend":"1","sendtype":null,"ucaddtime":1366887239000,"imgName":"116.jpg"}]}
     */
    NSLog(@"查询车辆===\n%@",[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding]);
    NSString* requestStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary* requestDic = [requestStr objectFromJSONString ];
    NSLog(@"requestDic = %@",requestDic);

    NSLog(@"requestDIc = %@",[requestDic objectForKey:@"list"] );
    //  NSString* ucidStr = [requestDic objectForKey:@"list"]
    
    
    
    //大写的,,,还有特殊情况
    if(![[requestDic objectForKey:@"status"] isEqualToString:@"8001"]){
    if([[requestDic objectForKey:@"list"] count]!= 0){
    NSString* brandStr = [[[[requestDic objectForKey:@"list"] objectAtIndex:0] objectForKey:@"brand"] uppercaseString];
    NSLog(@"brandStr ===%@", brandStr);
    //在些做判断，比较数据库中的数据

    int carCount = [self.carMutableArray count];
    for(int i = 0; i < carCount; i++){
        NSDictionary* tempDic = [self.carMutableArray objectAtIndex:i];
        NSString* tempBrand = [[tempDic objectForKey:@"carNum"] uppercaseString];
        if([brandStr isEqualToString:tempBrand]){//如果存在着设置isRemind设置为YES
      
            [tempDic setValue:@"YES" forKey:@"isRemind"];
            [self.carMutableArray replaceObjectAtIndex:i withObject:tempDic];
            [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
        }else{
            [tempDic setValue:@"NO" forKey:@"isRemind"];
            [self.carMutableArray replaceObjectAtIndex:i withObject:tempDic];
            [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
        }
        
    }
    //如果是非负费用户，着全部为NO

    
    NSLog(@"fffflag = %@",[[userDic objectForKey:@"flag"] class]);
    if(![userDic objectForKey:@"flag"]){
        int carCount = [self.carMutableArray count];
        for(int i = 0; i < carCount; i++){
            NSDictionary* tempDic = [self.carMutableArray objectAtIndex:i];
            [tempDic setValue:@"NO" forKey:@"isRemind"];
            [self.carMutableArray replaceObjectAtIndex:i withObject:tempDic];
            [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
        }
    }
    
    
    
    }
    }else{//list为空的时候
        NSLog(@"list为空");
        int carCount = [self.carMutableArray count];
        for(int i = 0; i < carCount; i++){
            NSDictionary* tempDic = [self.carMutableArray objectAtIndex:i];
            [tempDic setValue:@"NO" forKey:@"isRemind"];
            [self.carMutableArray replaceObjectAtIndex:i withObject:tempDic];
            [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
        }
    }
    
    
    [self initMainTableView];
}


-(void)initMainTableView{
   /* NSFileManager* fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:CARLISTFILEPATH]){
        [fileManage createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
    }
    self.carMutableArray = [NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH];
    NSLog(@"self.carMutableArray = %@", self.carMutableArray);*/
//    [mainTableView reloadData];
  /*  NSFileManager* userFile = [NSFileManager defaultManager];
    if(![userFile fileExistsAtPath:USERFILEPATH]){
        [userFile createFileAtPath:USERFILEPATH contents:nil attributes:nil];
    }
    userDic = [[NSDictionary alloc] initWithContentsOfFile:USERFILEPATH];*/
    if([userDic objectForKey:@"userID"] != nil){//如果不为空的话，说明有login过，判断用户类型
        NSString* name = [[CarManager sharedInstance] getUserName];
        NSString* pwd = [[CarManager sharedInstance] getPwd];
        NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/signIn/"];
        requestLogin = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [requestLogin setPostValue:name forKey:@"mobile"];
        [requestLogin setPostValue:pwd forKey:@"pwd"];
        [requestLogin setDelegate:self];
        [requestLogin setDidFinishSelector:@selector(login:)];
        [requestLogin setDidFailSelector:@selector(failed:)];
        [requestLogin startAsynchronous];
//        [CarManager sharedInstance].orderId = [[[[[NSString alloc] initWithData:[requestLogin responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"];
//        NSLog(@"orderId ============%@",[[[[[NSString alloc] initWithData:[requestLogin responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]);
        //        [requestForm setDidFailSelector:@selector(requestFailed:)];//失败
        //        [requestForm setDidFinishSelector:@selector(requestLogin:)];//成功
        //        [requestForm startAsynchronous];
        //[requestLogin startSynchronous];
            }else{//如果为空，就转到login
        NSUserDefaults* loginFile = [NSUserDefaults standardUserDefaults];
        [loginFile removeObjectForKey:@"hasLogin"];
        [loginFile setObject:@"NO" forKey:@"hasLogin"];
        
        loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}
//这个地方要改
-(void)login:(ASIHTTPRequest*)request{
    NSData* data = [requestLogin responseData];
    NSStringEncoding strEncode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    loginStr = [[NSString alloc] initWithData:data encoding:strEncode];
    NSLog(@"loginStr === %@",loginStr);
    
    
    /*
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/add/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requestForm setPostValue:@"阿斯顿·马丁" forKey:@"plate"];
    [requestForm setPostValue:@"599890" forKey:@"vin"];
    [requestForm setPostValue:@"116.jpg" forKey:@"imgName"];
    [requestForm setPostValue:@"a03Q37" forKey:@"brand"];
    [requestForm startSynchronous];
    [CarManager sharedInstance].orderId = [NSString stringWithFormat:@"%@",[[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]];
    NSLog(@"orderId ============%@",[[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]);
    */
    
    

}
-(void)failed:(ASIHTTPRequest*)request{
    [requestLogin error];
}



-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell;
//    if(indexPath.section == 0)
//    {
        cell = (remindCell*)[tableView dequeueReusableCellWithIdentifier:@"remindCell"];
        
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"remindCell" owner:self options:nil] lastObject];
        }
        NSString* tempImageStr;
        NSString* tempCarNumStr;
        
        //NSString* tempCarJiaStr;
        
        self.carDictionary = [self.carMutableArray objectAtIndex:indexPath.row];
        tempCarNumStr = [[self.carDictionary objectForKey:@"carNum"] uppercaseString];//车牌号
        //tempCarJiaStr = [self.carDictionary objectForKey:@"carJiaNum"];
       
        
        NSInteger row=[indexPath row];
    
        //转成大写 并加上 豫字
        NSLog(@"tempCarNumStr = %@",tempCarNumStr);
        NSMutableString* yu = [NSMutableString stringWithFormat:@"豫"];
        [yu appendString:tempCarNumStr];
        ((remindCell*)cell).carNumberLabel.text = yu;
        tempImageStr = [self.carDictionary objectForKey:@"carImageNum"];
        ((remindCell*)cell).carImageView.image = [UIImage imageNamed:tempImageStr];
    
    
    
        ((remindCell*)cell).remindViewControllerDelegate = self;
        ((remindCell*)cell).kaiguan.tag=row+100;
   //此处设置单元格状态,数据需存入数据库-----------------------------------------------------------------------------------------------------
    if([[self.carDictionary objectForKey:@"isRemind"] isEqualToString:@"YES"]){
        ((remindCell*)cell).kaiguan.selected= YES;
    }else{
        ((remindCell*)cell).kaiguan.selected=NO;
    }
    
    
    //-----------------------------------------------------------------------------------------------------
    
       n=row;
       ((remindCell*)cell).delegate=self;
        NSLog(@"%i",row);
    
    
    
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_more_item_middle.png"]];
        
        
//    }else{//添加车辆
//        cell = (AddButtonCell*)[tableView dequeueReusableCellWithIdentifier:@"AddButtonCell"];
//        if(!cell){
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddButtonCell" owner:self options:nil] lastObject];
//            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_normal.png"]];
//        }
//        ((AddButtonCell*)cell).indexVC = self;
//    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section == 0)return 80.0f;
//    if(indexPath.section == 1)return 44.0f;
    return 65.0f;
}

-(IBAction)remindBtn:(id)sender{
    /*
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/add/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requestForm setPostValue:@"阿斯顿·马丁" forKey:@"plate"];
    [requestForm setPostValue:@"599890" forKey:@"vin"];
    [requestForm setPostValue:@"116.jpg" forKey:@"imgName"];
    [requestForm setPostValue:@"a03Q37" forKey:@"brand"];
    [requestForm startSynchronous];
    */
    NSString* AddString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/findCarByUser/"];
//    ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:AddString]];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:AddString]];
//    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request startSynchronous];
    
    /*
     {"message":null,"data":null,"status":"8000","list":[{"ucid":95,"userid":20,"plate":"阿斯顿·马丁","vin":"599890","brand":"a03Q37","issend":"1","sendtype":null,"ucaddtime":1366887239000,"imgName":"116.jpg"}]}
     */
    NSLog(@"response===\n%@",[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding]);
    NSString* requestStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary* requestDic = [requestStr objectFromJSONString ];
    NSLog(@"requestDic = %@",requestDic);
    NSLog(@"requestDIc = %d",[[requestDic objectForKey:@"list"] indexOfObject:0]);
  //  NSString* ucidStr = [requestDic objectForKey:@"list"]
    NSDictionary* listDic = [[requestDic objectForKey:@"list"] objectAtIndex:0 ];
    NSString* ucidStr = [listDic objectForKey:@"ucid"];
    NSLog(@"ucidStr = %@",ucidStr);
    

    NSString* DelString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/del/"];
    
    ASIFormDataRequest* delRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:DelString]];
    [delRequest setPostValue:ucidStr forKey:@"carId"];
    [delRequest startSynchronous];
    NSLog(@"delString\n%@",[[NSString alloc] initWithData:[delRequest responseData] encoding:NSUTF8StringEncoding]);
    
    NSString* ddString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/findCarByUser/"];
    //    ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:AddString]];
    ASIFormDataRequest* requestnext = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ddString]];
    //    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [requestnext startSynchronous];
    NSLog(@"requestnext\n%@",[[NSString alloc] initWithData:[requestnext responseData] encoding:NSUTF8StringEncoding]);
    
    
    
    
    
    /*
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/del/"];
    
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requestForm setPostValue:@"阿斯顿·马丁" forKey:@"plate"];
    [requestForm setPostValue:@"599890" forKey:@"vin"];
    [requestForm setPostValue:@"116.jpg" forKey:@"imgName"];
    [requestForm setPostValue:@"a03Q37" forKey:@"brand"];
    [requestForm startSynchronous];
 
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);*/
}



-(void)baoche:(id)sender{
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/carInfo/add/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requestForm setPostValue:@"阿斯顿·马丁" forKey:@"plate"];
    [requestForm setPostValue:@"599890" forKey:@"vin"];
    [requestForm setPostValue:@"116.jpg" forKey:@"imgName"];
    [requestForm setPostValue:@"a03Q37" forKey:@"brand"];
    [requestForm startSynchronous];
    loginIsYes=[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"message"];
    NSLog(@"response\n%@",[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"message"]);
//    [CarManager sharedInstance].orderId = [[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"];
//    NSLog(@"orderId ============%@",[[[[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding] objectFromJSONString] objectForKey:@"data"]objectForKey:@"orderId"]);
}
-(IBAction)goBack:(id)sender{
//    [self.navigationController popViewControllerAnimated:YES];
    indexViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH] count];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 1;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
