//
//  RootViewController.m
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

#import "RootViewController.h"
#import "MBProgressHUD.h"

@interface RootViewController ()

@property (nonatomic) MBProgressHUD *progressHUD;

@end

@implementation RootViewController

#pragma mark - Инициализация

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Методы работы с информационными сообщениями

- (void)showError:(NSString*)text
{
    [self showError:text withDelegate:nil];
}

- (void)showError:(NSString*)text withDelegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:text
                                                        delegate:delegate
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    
    [alert_view show];
    
    alert_view.accessibilityLabel = @"Error";
}

#pragma mark - Индикация загрузки данных

- (void)showLoading
{
    [self showLoadingText:@""];
}

- (void)showLoadingText:(NSString*)text
{
    if (self.progressHUD == nil)
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    self.progressHUD.dimBackground = YES;
    if (text.length > 0)
        self.progressHUD.labelText = text;
    
    if (self.progressHUD.superview == nil) {
        [self.view addSubview:self.progressHUD];
        [self.progressHUD show:YES];
    }
    
}

- (void)hideLoading
{
    if (self.progressHUD == nil)
        return;
    
    [self.progressHUD hide:YES];
    if (self.progressHUD.superview != nil)
        [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}

@end
