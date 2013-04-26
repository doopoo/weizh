//
//  NewPassword.h
//  TrafficQuery
//
//  Created by hz on 13-4-24.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASIFormDataRequest;
@class LoginViewController;
@interface NewPassword : UIViewController{
    UITextField* oldPwd;
    UITextField* password;
    UITextField* againPwd;
    ASIFormDataRequest* requests;
    LoginViewController* loginViewController;
}
@property(nonatomic, retain)IBOutlet UITextField* oldPwd;
@property(nonatomic, retain)IBOutlet UITextField* password;
@property(nonatomic, retain)IBOutlet UITextField* againPwd;

-(IBAction)goBack:(id)sender;
-(IBAction)changePassword:(id)sender;

@end
