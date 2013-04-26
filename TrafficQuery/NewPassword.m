//
//  NewPassword.m
//  TrafficQuery
//
//  Created by hz on 13-4-24.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "NewPassword.h"
#import "LoginViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@interface NewPassword ()

@end

@implementation NewPassword
@synthesize oldPwd;
@synthesize password;
@synthesize againPwd;

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
}
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)changePassword:(id)sender{
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/userInfo/updatePwd/"];
    requests = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requests setPostValue:self.oldPwd.text forKey:@"oldpwd"];
    [requests setPostValue:self.password.text forKey:@"pwd"];
    [requests setDelegate:self];
    [requests setDidFinishSelector:@selector(succeed:)];
    [requests setDidFailSelector:@selector(failed:)];
    [requests startAsynchronous];
   

}
//成功
-(void)succeed:(ASIHTTPRequest*)request{
    //成功登陆,并进行转场
    
    NSLog(@"response修改\n%@",[[NSString alloc] initWithData:[requests responseData] encoding:NSUTF8StringEncoding]);
    
    NSData* data = [request responseData];
    NSStringEncoding strEncode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSString* str = [[NSString alloc] initWithData:data encoding:strEncode];
    NSLog(@"str = %@", str);
    
    NSDictionary* dataDic = [str objectFromJSONString];
    NSLog(@"dataDic = %@", dataDic);
    //登陆成功---要进行保存
    if([[dataDic objectForKey:@"status"] isEqualToString:@"8000"]){
        NSLog(@"密码修改成功");
        loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
        
    }
    
}
-(void)failed:(ASIHTTPRequest*)request{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
