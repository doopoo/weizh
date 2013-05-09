//
//  UpgradeViewController.m
//  TrafficQuery
//
//  Created by hz on 13-5-3.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "UpgradeViewController.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "DataSigner.h"
#import "CarManager.h"
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
    
    /*
     *商户的唯一的parnter和seller。
     *本demo将parnter和seller信息存于（AlixPayDemo-Info.plist）中,外部商户可以考虑存于服务端或本地其他地方。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    //如果partner和seller数据存于其他位置,请改写下面两行代码
    NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    /*
     *生成订单信息及签名
     *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = partner;
    order.seller = seller;
    //---------------------
    order.tradeNO = [CarManager sharedInstance].orderId;
    NSLog(@"tradeNO = %@", [CarManager sharedInstance].orderId);
    //order.tradeNO = @"123456"; //订单ID（由商家自行制定）
    NSLog(@"-------%@----------", order.tradeNO);
    
    if ([order.tradeNO isEqualToString:@"0"]) {
        NSLog(@"--------------generateTradeNO fail------------");
        return;
    }
    
    
    order.productName = @"河南违章查询"; //商品标题
    order.productDescription = @"河南违章查询和推送服务一年"; //商品描述
    order.amount = [NSString stringWithFormat:@"60.00"]; //商品价格
    order.notifyURL =  @"http://uc.chexingle.com/car/chenglianPay/pay/"; //回调URL
    
    //NSLog(@"-------doopooooooooo---------");
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
    NSString *appScheme = @"ChengLianClient";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        //获取安全支付单例并调用安全支付接口
        AlixPay * alixpay = [AlixPay shared];
        int ret = [alixpay pay:orderString applicationScheme:appScheme];
        
        if (ret == kSPErrorAlipayClientNotInstalled) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝的客户端，请先装。"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView setTag:123];
            [alertView show];
            [alertView release];
        }
        else if (ret == kSPErrorSignError) {
            NSLog(@"签名错误！");
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
