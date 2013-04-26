//
//  RegisterViewController.m
//  TrafficQuery
//
//  Created by han zhen on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "ASIFormDataRequest.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize telphoneNum, yanzhengNum, passwordNum, againPasswordNum;
@synthesize titleLabel, titleStr;

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
    againPasswordNum.delegate=self;
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = titleStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//这个有点难度
-(IBAction)getYanZheng:(id)sender{
    NSString* urlString = [NSString stringWithFormat:@"http://uc.chexingle.com:8080/car/verCode/getCode/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSString* telphoneStr = self.telphoneNum.text;
    NSLog(@"request---mobile = %@",telphoneStr);
    [requestForm setPostValue:telphoneStr forKey:@"mobile"];
    [requestForm startSynchronous];
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);
    /*
     response
     {"message":"手机号已存在","data":null,"status":"8001","list":null}
     */
    
}

-(IBAction)registerNow:(id)sender{
    NSString* urlString = [NSString stringWithFormat:@"http://uc.chexingle.com:8080/car/register/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSString* telphone = self.telphoneNum.text;
    NSString* password = self.passwordNum.text;
    NSString* rePassword = self.againPasswordNum.text;
    NSString* yanzheng = self.yanzhengNum.text;
    [requestForm setPostValue:telphone forKey:@"mobile"];
    [requestForm setPostValue:password forKey:@"pwd"];
    [requestForm setPostValue:rePassword forKey:@"repwd"];
    [requestForm setPostValue:yanzheng forKey:@"code"];
    [requestForm startSynchronous];
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);
    
}

- (void)scrollIfNeeded:(NSNumber *)yCenterPos {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
    //loginBg.center = CGPointMake(loginBg.center.x, [yCenterPos floatValue]);
  //-  homeBgView.center = CGPointMake(homeBgView.center.x, [yCenterPos floatValue]);

	[UIView commitAnimations];
}

//该方法为点击输入文本框要开始输入是调用的代理方法：就是把view上移到能看见文本框的地方
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    [self performSelectorOnMainThread:@selector(scrollIfNeeded:) withObject:[NSNumber numberWithFloat:80.0f] waitUntilDone:NO];
    
    CGFloat keyboardHeight = 216.0f;
    if ((self.view.frame.size.height - keyboardHeight) <= (textField.frame.origin.y + textField.frame.size.height)){
        
        [UIView beginAnimations:@"srcollView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        textField.frame = CGRectMake(textField.frame.origin.x,textField.frame.origin.y-40, textField.frame.size.width, textField.frame.size.height);
        passwordNum.frame = CGRectMake(passwordNum.frame.origin.x,passwordNum.frame.origin.y-20, textField.frame.size.width, textField.frame.size.height);
        [UIView commitAnimations];
    }
    
}

//该方法为完成输入后要调用的代理方法：虚拟键盘隐藏后，要恢复到之前的文本框地方
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@"srcollView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    textField.frame = CGRectMake(textField.frame.origin.x, 245, textField.frame.size.width, textField.frame.size.height);
    passwordNum.frame = CGRectMake(passwordNum.frame.origin.x,191, textField.frame.size.width, textField.frame.size.height);
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [telphoneNum resignFirstResponder];
    [yanzhengNum resignFirstResponder];
    [passwordNum resignFirstResponder];
    [againPasswordNum resignFirstResponder];
}
//改变输入框焦点
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == passwordNum)
    {
        [passwordNum resignFirstResponder];
        //[pwdTextField becomeFirstResponder];
    }else
    {
        [againPasswordNum resignFirstResponder];
    }
    
    [self performSelectorOnMainThread:@selector(scrollIfNeeded:) withObject:[NSNumber numberWithFloat:230.0f] waitUntilDone:NO];
    return YES;
}

-(void)dealloc{
    [titleStr release];
    [super dealloc];
}



@end
