//
//  ShareViewController.h
//  TrafficQuery
//
//  Created by tianjing on 13-4-25.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "TCWBEngine.h"
#import "WXApi.h"

#define kAppKey             @"1986722134"
#define kAppSecret          @"fb2ff04aabcb3024403560faeed01847"
#define kAppRedirectURI     @"http://www.sina.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@protocol ShareViewControllerdelegate <NSObject>

-(void)WXShare;

@end

@interface ShareViewController : UIViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate,WXApiDelegate,UITextViewDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
{
    enum WXScene _scene;
    SinaWeibo *sinaweibo;
    TCWBEngine *weiboEngine;
    UITextView *wbContent;
    UIButton *SNLogButton;
    UIButton *TCLogButton;
    UIButton *sendButton;
    UILabel *TCLabel;
    UILabel *SNLabel;
    BOOL TCOpen;
    BOOL SNOpen;
    UIActivityIndicatorView     *indicatorView;
    UIButton                    *btnLogout;
    
}

@property(nonatomic,assign)id<ShareViewControllerdelegate> delegate;
-(void)TCSetButtonBgImage:(UIImage*)image labelText:(NSString*)text;
-(void)SNSetButtonBgImage:(UIImage*)image labelText:(NSString*)text;

@property (strong,nonatomic) SinaWeibo *sinaweibo;
@property (nonatomic, retain) TCWBEngine   *weiboEngine;
//@property (nonatomic, retain) UIButton      *logInBtnOAuth;

@end
