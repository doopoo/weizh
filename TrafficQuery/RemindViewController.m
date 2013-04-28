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

#import "JSONKit.h"
#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]

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
    int m;
    UIButton* myBtn = (UIButton*)sender;
    m=myBtn.tag;
    NSLog(@"%i~~%i",m,n);


    for (int j=0; j<=n; j++) {
        UIButton* myBtn1 = (UIButton*)[[[[myBtn superview] superview]superview] viewWithTag:j+100];
        NSLog(@"~!%@",myBtn1);
        myBtn1.selected = NO;
    }
    
    [myBtn setBackgroundColor:[UIColor clearColor]];
    [myBtn setImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateNormal];
    [myBtn setImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateSelected];
    [self touchEvent:myBtn];
}
-(void)touchEvent:(id)sender{
    UIButton* button = (UIButton*)sender;
    button.selected = !button.selected;
    if(button.imageView.image == [UIImage imageNamed:@"kai.png"]){
        NSLog(@"开着呢");
    }
    if(isON == NO){
        isON = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initMainTableView];
}
-(void)initMainTableView{
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:CARLISTFILEPATH]){
        [fileManage createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
    }
    self.carMutableArray = [NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH];
    NSLog(@"self.carMutableArray = %@", self.carMutableArray);
//    [mainTableView reloadData];
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
    ((remindCell*)cell).kaiguan.selected=NO;
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
    return 80.0f;
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
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);
}
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
