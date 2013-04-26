//
//  LoginViewController.m
//  TrafficQuery
//
//  Created by han zhen on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "LoginViewController.h"
#import "IndexViewController.h"
#import "RegisterViewController.h"
#import "UserViewController.h"
#import "CarManager.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#define USERFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/User.plist"]
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize telphoneTextField;
@synthesize passwordTextField;
@synthesize backgroundImageView;



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
    UITapGestureRecognizer* tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}
//添加手势,让键盘消失
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    
    [telphoneTextField resignFirstResponder];
    //[pwdTextField becomeFirstResponder];
    
    
    [passwordTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)login:(id)sender{
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"正在登陆。。。";
    
    NSString* name = self.telphoneTextField.text;
    NSString* pwd = self.passwordTextField.text;
    if(name.length != 11 || pwd.length == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"手机号或密码不能为空哦!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/signIn/"];
   // NSString* urlString = [NSString stringWithFormat:@"http://116.255.238.9/car/signIn/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requestForm setPostValue:name forKey:@"mobile"];
    [requestForm setPostValue:pwd forKey:@"pwd"];
    [requestForm setDelegate:self];
    [requestForm setDidFailSelector:@selector(requestFailed:)];//请求失败的回调
    [requestForm setDidFinishSelector:@selector(requestLogin:)];
    [HUD showAnimated:YES whileExecutingBlock:^{
    [requestForm startAsynchronous];
    
        sleep(2);}completionBlock:^{
//    [requestForm setPostValue:@"13949068621" forKey:@"mobile"];
//    [requestForm setPostValue:@"12345609" forKey:@"pwd"];
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;}];
    } 
}
-(void)requestLogin:(ASIHTTPRequest*)request{
    
    
    [request setUseCookiePersistence:YES];
    
    
    NSData* data = [request responseData];
    NSStringEncoding strEncode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSString* str = [[NSString alloc] initWithData:data encoding:strEncode];
    NSLog(@"str = %@", str);
    
    NSDictionary* dataDic = [str objectFromJSONString];
    NSLog(@"dataDic = %@", dataDic);
    //登陆成功
    if([[dataDic objectForKey:@"status"] isEqualToString:@"8000"]){
        //记住用户名和密码
        [[CarManager sharedInstance] saveUserNameAndPwd:self.telphoneTextField.text andPwd:self.passwordTextField.text];
        NSLog(@"userName = %@",[[CarManager sharedInstance] getUserName]);
        NSLog(@"password = %@", [[CarManager sharedInstance] getPwd]);
        
        /*
        NSLog(@"message = %@",[dataDic objectForKey:@"message"]);
        NSLog(@"data = %@",[[dataDic objectForKey:@"data"] objectForKey:@"flat"]);
        NSDictionary* headerDic = [request responseHeaders];
        NSLog(@"headerDic,class%@",[headerDic class]);
        NSLog(@"headerDic =\n %@",headerDic);
        NSString* cookieStr = [headerDic objectForKey:@"Set-Cookie"];
        NSLog(@"cookieStr = %@",cookieStr);
        NSLog(@"cookieStr class= %@",[cookieStr class]);
        */
        /*
         {"status":"8000","message":"登录成功","data":{"status":"0","start":"2013-04-20 03:49:45","flat":"1","payType":"2","end":"2013-04-21 03:49:45"}}
         */
        NSString* payType = [[dataDic objectForKey:@"data"] objectForKey:@"payType"];
        NSString* flag = [[dataDic objectForKey:@"data"] objectForKey:@"flat"];
        NSString* end = [[dataDic objectForKey:@"data"] objectForKey:@"end"];
        NSString* status = [[dataDic objectForKey:@"data"] objectForKey:@"status"];
        NSLog(@"payType = %@, flat = %@, end = %@, status = %@", payType, flag, end, status);
        
        

        /////////////////////////////////////////
        //把个人信息存入plist文件中
        
        
        
        
        
        
        NSFileManager* userFile = [NSFileManager defaultManager];
        if(![userFile fileExistsAtPath:USERFILEPATH]){
            [userFile createFileAtPath:USERFILEPATH contents:nil attributes:nil];
        }
        NSDictionary* userDict = [[NSDictionary alloc] initWithObjectsAndKeys:self.telphoneTextField.text,@"userID",
                                  payType, @"payType", flag, @"flag", end, @"end", status, @"status",nil];
        [userDict writeToFile:USERFILEPATH atomically:YES];
        
         
        userViewController = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:nil];

        [self.navigationController pushViewController:userViewController animated:YES];
       
        
        
        
        /*
         headerDic = 
         {
         Connection = close;
         "Content-Length" = 62;
         Date = "Tue, 23 Apr 2013 03:28:07 GMT";
         Server = "nginx/1.0.15";
         "Set-Cookie" = "JSESSIONID=587268CB0D925B0C02FEC7672B1A80FF; Path=/car, mobile=\"R2dGAiQskAmCHjXcF5Txyw==\"; Version=1; Max-Age=1800; Expires=Tue, 23-Apr-2013 03:58:07 GMT; Path=/";
         }

         */
        

        
    }else{
         NSLog(@"失败");
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
   // NSLog(@"失败");
}
-(IBAction)register:(id)sender{
    registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    registerViewController.titleStr = @"注册";
    [self.navigationController pushViewController:registerViewController animated:YES];
}
-(IBAction)goBack:(id)sender{
    indexViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
}
-(IBAction)findPassword:(id)sender{
    registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    registerViewController.titleStr = @"找回密码";
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)scrollIfNeeded:(NSNumber *)yCenterPos {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];

    backgroundImageView.center = CGPointMake(backgroundImageView.center.x, [yCenterPos floatValue]);
    
	[UIView commitAnimations];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self performSelectorOnMainThread:@selector(scrollIfNeeded:) withObject:[NSNumber numberWithFloat:80.0f] waitUntilDone:NO];
}
//改变输入框焦点
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == telphoneTextField)
    {
        [telphoneTextField becomeFirstResponder];
        //[pwdTextField becomeFirstResponder];
    }else
    {
        [passwordTextField resignFirstResponder];
    }
    
    [self performSelectorOnMainThread:@selector(scrollIfNeeded:) withObject:[NSNumber numberWithFloat:230.0f] waitUntilDone:NO];
    return YES;
}

@end
