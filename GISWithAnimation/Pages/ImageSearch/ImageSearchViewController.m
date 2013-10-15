//
//  ImageSearchViewController.m
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

#import "ImageSearchViewController.h"
#import "GoogleImageSearchManager.h"
#import "ResultSearchViewController.h"

@interface ImageSearchViewController ()

@property (nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation ImageSearchViewController

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
    self.searchTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate Methods

/*
 *  Метод обрабатывает нажатие кнопки поиска на клавиатуре
 */
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    [self searchImageWithTitle:textField.text];
    return YES;
}

#pragma mark - UIButton Clicked Methods

/*
 *  Метод обрабатывает нажатие по кнопке поиска изображения
 */
- (IBAction)searchButtonClicked:(id)sender
{
    [self.searchTextField resignFirstResponder];
    [self searchImageWithTitle:self.searchTextField.text];
}

#pragma mark - Приватные методы

/*
 *  Метод осуществляет поиск необходимого изображения
 */
- (void)searchImageWithTitle:(NSString*)imageTitle
{
    if (imageTitle.length == 0) {
        [self showError:@"image search field is null"];
        return;
    }
    
    [self showLoading];
    [[GoogleImageSearchManager instance] searchImageWithTitle:imageTitle
                                                 minPageIndex:0
                                                 maxPageIndex:32
                                                 onCompletion:^(NSArray *data) {
                                                     resultImageArray = [data copy];
                                                     [self performSegueWithIdentifier:@"PushToResultSearchVC" sender:self];
                                                 } onError:^(NSError *error) {
                                                     [self hideLoading];
                                                     [self showError:@"image search error"];
                                                 }];
}

#pragma mark - Navigation Methods

/*
 *  Метод отслеживает переходы
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //  Переход на экран результата поиска
    if ([segue.identifier isEqualToString:@"PushToResultSearchVC"] == YES) {
        ResultSearchViewController *result_search_vc = segue.destinationViewController;
        result_search_vc.dictionaryImagesList = resultImageArray;
        result_search_vc.searchImageTitle = self.searchTextField.text;
        result_search_vc.minPageIndex = 36;
        [self hideLoading];
    }
}

@end
