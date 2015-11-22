//
//  MainViewController.m
//  SinaLoginDemo
//
//  Created by vimfung on 13-8-18.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "MainViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logoutButtonClickHandler:)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutButtonClickHandler:(id)sender
{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    
    [self.navigationController popViewControllerAnimated:NO];
}

@end
