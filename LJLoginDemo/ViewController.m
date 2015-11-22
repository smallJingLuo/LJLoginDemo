//
//  ViewController.m
//  LogInDemo
//
//  Created by 成都千锋 on 15/11/14.
//  Copyright (c) 2015年 成都千锋. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

#import <ShareSDK/ShareSDK.h>

#import <Parse/Parse.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    
    //添加背景
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLogin.png"]];
    bgImgView.frame = self.view.frame;
    [self.view addSubview:bgImgView];
    
    //添加登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake((self.view.frame.size.width - 173.0) / 2, (self.view.frame.size.height - 32.0) / 2, 173.0, 32.0);
    loginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [loginBtn addTarget:self action:@selector(loginBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)loginBtnClickHandler:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
                                   [query whereKey:@"uid" equalTo:[userInfo uid]];
                                   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                       
                                       if ([objects count] == 0)
                                       {
                                           PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                                           [newUser setObject:[userInfo uid] forKey:@"uid"];
                                           [newUser setObject:[userInfo nickname] forKey:@"name"];
                                           [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                                           [newUser saveInBackground];
                                           
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎注册" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                           [alertView show];
                                          
                                       }
                                       else
                                       {
                                           
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎回来"delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                           [alertView show];
                                           NSString *name= userInfo.nickname;
                                           NSLog(@"%@",name);
                                           NSString *image= userInfo.profileImage;
                                           NSLog(@"%@",image);
                                       }
                                   }];
                                   
                                   MainViewController *mainVC = [[MainViewController alloc] init];
                                   [self.navigationController pushViewController:mainVC animated:YES];
                                   
                               }
                               
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
