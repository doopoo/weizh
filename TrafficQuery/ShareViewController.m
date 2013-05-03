//
//  ShareViewController.m
//  TrafficQuery
//
//  Created by tianjing on 13-4-25.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "ShareViewController.h"
#import "HomeIntroduce.h"
#import <QuartzCore/QuartzCore.h>
@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize delegate=_delegate;
@synthesize sinaweibo;
@synthesize weiboEngine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [SNLogButton release];
    [TCLogButton release];
    [SNLabel release];
    [TCLabel release];
    [sendButton release];
    [wbContent release];
    [weiboEngine release],weiboEngine = nil;
    [indicatorView release],indicatorView = nil;
    [super dealloc];
}

-(void)TCSetButtonBgImage:(UIImage*)image labelText:(NSString*)text
{
    [TCLogButton setBackgroundImage:image forState:UIControlStateNormal];
    TCLabel.text = text;
}

-(void)SNSetButtonBgImage:(UIImage*)image labelText:(NSString*)text
{
    [SNLogButton setBackgroundImage:image forState:UIControlStateNormal];
    SNLabel.text = text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_bg.png"]];
    [self.view addSubview:bgView];
    UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top_panal_background.png"]];
    [topView setFrame:CGRectMake(0, 0, 320, 60)];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 8, 50, 30)];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_a.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_b.png"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(120, 3, 140, 40)];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    titleLable.text = @"分享给朋友";
    titleLable.font = [UIFont systemFontOfSize:20];
    

 // 腾讯微博初始化
    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.ying7wang7.com"];
    [engine setRootViewController:self];
    self.weiboEngine = engine;
    [engine release];

    TCLogButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 190,30, 30)];
    TCLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 185, 35, 40)];
    TCLabel.font = [UIFont fontWithName:@"Arial" size:8];
    TCLabel.numberOfLines = 2;
    [TCLabel setBackgroundColor:[UIColor clearColor]];
    if(weiboEngine.isLoggedIn)
    {
        TCOpen = YES;
        [self TCSetButtonBgImage:[UIImage imageNamed:@"tencent_1.png"] labelText:@"腾讯微博已授权"];
    }
    else
    {
        TCOpen = NO;
       [self TCSetButtonBgImage:[UIImage imageNamed:@"tencent_2.png"] labelText:@"腾讯微博未授权"]; 
    }
    [TCLogButton addTarget:self action:@selector(TCOnLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TCLogButton];
    [self.view addSubview:TCLabel];
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(160, 240)];
    [self.view addSubview:indicatorView];
 
 //新浪微博初始化
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    NSLog(@"%@",sinaweiboInfo);
    SNLogButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 190, 30, 30)];
    SNLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 185, 35, 40)];
    SNLabel.font = [UIFont fontWithName:@"Arial" size:8];
    SNLabel.numberOfLines = 2;
    [SNLabel setBackgroundColor:[UIColor clearColor]];
    if(sinaweibo.isLoggedIn)
    {
        SNOpen = YES;
        [self SNSetButtonBgImage:[UIImage imageNamed:@"sina_1.png"] labelText:@"新浪微博已授权"];
    }
    else
    {
        SNOpen = NO;
        [self SNSetButtonBgImage:[UIImage imageNamed:@"sina_2.png"] labelText:@"新浪微博未授权"];
    }

    [SNLogButton addTarget:self action:@selector(SNOnLogin:) forControlEvents:UIControlEventTouchUpInside];
//微信
    UIButton *WXShareButton = [[UIButton alloc]initWithFrame:CGRectMake(180, 190, 30, 30)];
    [WXShareButton setBackgroundImage:[UIImage imageNamed:@"weixin.png"] forState:UIControlStateNormal];
    [WXShareButton addTarget:self action:@selector(WXShare) forControlEvents:UIControlEventTouchUpInside];
    UILabel *WXLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 185, 20, 40)];
    WXLabel.font = [UIFont fontWithName:@"Arial" size:8];
    WXLabel.text = @"微信分享";
    WXLabel.numberOfLines = 2;
    [WXLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:WXLabel];
    [self.view addSubview:WXShareButton];
//短信
    UIButton *messageShareButton = [[UIButton alloc]initWithFrame:CGRectMake(250, 190, 30, 30)];
    [messageShareButton setBackgroundImage:[UIImage imageNamed:@"news.png"] forState:UIControlStateNormal];
    [messageShareButton addTarget:self action:@selector(messageShare) forControlEvents:UIControlEventTouchUpInside];
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(280, 185, 20, 40)];
    messageLabel.font = [UIFont fontWithName:@"Arial" size:8];
    messageLabel.text = @"短信分享";
    messageLabel.numberOfLines = 2;
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:messageLabel];
    [self.view addSubview:messageShareButton];
    
    sendButton = [[UIButton alloc]initWithFrame:CGRectMake(25, 250, 250, 40)];
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
    [sendButton setTitle:@"微博发送" forState:UIControlStateNormal];  [sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    
    wbContent = [[UITextView alloc]initWithFrame:CGRectMake(10, 65, 300, 110)];
    wbContent.text = @"河南车主有福了！我正在用＃河南违章查询＃，省内省外违章不仅能查，更能及时提醒。赶快下载体验http://www.chexingle.com/";
    wbContent.font = [UIFont fontWithName:@"Arial" size:15];
    wbContent.layer.borderColor = [UIColor grayColor].CGColor;
    wbContent.layer.borderWidth =1.0;
    wbContent.layer.cornerRadius =6.0;
    wbContent.delegate = self;
    //[self resetButton];

    [self.view addSubview:SNLogButton];
    [self.view addSubview:SNLabel];
    [self.view addSubview:sendButton];
    [self.view addSubview:wbContent];
    [self.view addSubview:topView];
    [self.view addSubview:titleLable];
    [self.view addSubview:backButton];    
    [titleLable release];
    [backButton release];
    [topView release];    
}

//制定短信内容
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients

{
    
    
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    
    if([MFMessageComposeViewController canSendText])
        
        
    {
        
        
        controller.body = bodyOfMessage;
        
        
        controller.recipients = recipients;
        
        
        controller.messageComposeDelegate = self;
        
        
        [self presentModalViewController:controller animated:YES];
        
        
    }
    
    
}
//d短信的回调函数
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
        UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"Message cancelled" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        [aler release];
    }
    else if (result == MessageComposeResultSent)
    {
        UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"Message sent succeed" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        [aler release];
        NSLog(@"Message sent");
    }
    else
    {
        UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"Message failed" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        [aler release];
        NSLog(@"Message failed")  ;
    }
}

-(void)WXShare{

    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = @"qwertyuiop[";
    req.scene = _scene;
    [WXApi sendReq:req];
}

-(void)messageShare{
        [self sendSMS:@"河南车主有福了！我正在用＃河南违章查询＃，省内省外违章不仅能查，更能及时提醒。赶快下载体验http://www.chexingle.com/" recipientList:nil];
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }

    return YES;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [indicatorView release],indicatorView = nil;
}
//新浪用户保存
- (void)storeAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#if 0
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}
#endif

//腾讯微博授权
- (void)TCOnLogin{
    if([weiboEngine isLoggedIn])
    { 
        if([TCLabel.text isEqualToString:@"腾讯微博已关闭"])
        {
          [self TCSetButtonBgImage:[UIImage imageNamed:@"tencent_1.png"] labelText:@"腾讯微博已授权"];
          TCOpen = YES;
        }
        else
        {
            [self TCSetButtonBgImage:[UIImage imageNamed:@"tencent_3.png"] labelText:@"腾讯微博已关闭"];
            TCOpen = NO;
 
        }
    }
    else
    {
     [weiboEngine logInWithDelegate:self
                         onSuccess:@selector(onSuccessLogin)
                         onFailure:@selector(onFailureLogin:)];
    }
}
//登录成功回调
- (void)onSuccessLogin
{
    [indicatorView stopAnimating];
    [self TCSetButtonBgImage:[UIImage imageNamed:@"tencent_1.png"] labelText:@"腾讯微博已授权"];
    TCOpen = YES;
}

//登录失败回调
- (void)onFailureLogin:(NSError *)error
{
    [indicatorView stopAnimating];
    NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    [message release];
}


//新浪微博授权
-(void)SNOnLogin:(id)sender{
    if([sinaweibo isLoggedIn])
    {
        if([SNLabel.text isEqualToString:@"新浪微博已关闭"])
        {
            [self SNSetButtonBgImage:[UIImage imageNamed:@"sina_1.png"] labelText:@"新浪微博已授权"];
            SNOpen = YES;
        }
        else
        {
            [self SNSetButtonBgImage:[UIImage imageNamed:@"sina_3.png"] labelText:@"新浪微博已关闭"];
            SNOpen = NO;
            
        }
    }

    else
        [sinaweibo logIn];
    
    // [self resetButton];
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweibosucced");
    [self storeAuthData];
    [self SNSetButtonBgImage:[UIImage imageNamed:@"sina_1.png"] labelText:@"新浪微博已授权"];
    SNOpen = YES;
    //[self resetButton];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    //[self removeAuthData];
    //  [self resetButton];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    
}

//微博发送
-(void)send:(id)sender{
    if(!wbContent.text)
    {
        [wbContent.text release],wbContent.text = nil;
        wbContent.text = [[NSString alloc]initWithFormat:@"河南车主有福了！我正在用＃河南违章查询＃，省内省外违章不仅能查，更能及时提醒。赶快下载体验http://www.chexingle.com/"];
    }
    
    if([weiboEngine isLoggedIn]&&TCOpen)
    {
        UIImage *img = [UIImage imageNamed:@"about_logo.jpg"];
        NSData *dataImage = UIImageJPEGRepresentation(img, 1.0);
        [self.weiboEngine postPictureTweetWithFormat:@"json"
                                             content:wbContent.text clientIP:@"10.10.1.38"
                                                 pic:dataImage
                                      compatibleFlag:@"0"
                                           longitude:nil
                                         andLatitude:nil
                                         parReserved:nil
                                            delegate:self
                                           onSuccess:@selector(createSuccess:)
                                           onFailure:@selector(createFail:)];
    }
    
    if([sinaweibo isLoggedIn]&&SNOpen)
    {
        [sinaweibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   wbContent.text, @"status",
                                   [UIImage imageNamed:@"about_logo.jpg"], @"pic", nil]
                       httpMethod:@"POST"
                         delegate:self];
    }
    
}

//腾讯发送委托
#pragma mark -
#pragma mark - creatSuccessOrFail


- (void)createSuccess:(NSDictionary *)dict {
   // NSLog(@"%s %@", __FUNCTION__,dict);
    if ([[dict objectForKey:@"ret"] intValue] == 0) {
        [self showAlertMessage:@"腾讯微博发送成功！"];
        NSLog(@"tc send success");
    }else {
        [self showAlertMessage:@"腾讯微博发送失败！"];
        NSLog(@"tc send success fail");
    }
}

- (void)createFail:(NSError *)error {
    NSLog(@"tc error is ");
    [self showAlertMessage:@"腾讯微博发送失败"];
}

- (void)showAlertMessage:(NSString *)msg {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:msg delegate:self cancelButtonTitle:@"确定"
           otherButtonTitles:nil];
    [alertView show];
    [alertView release];

}


//新浪微博发送委托
#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        [self showAlertMessage:@"新浪微博发送失败!"];
        
        NSLog(@"sn Post status failed with error : %@", error);
    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        [self showAlertMessage:@"新浪微博发送成功！"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
