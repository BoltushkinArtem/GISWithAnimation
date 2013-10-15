//
//  AnimationImageViewController.m
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

#import "AnimationImageViewController.h"

@interface AnimationImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation AnimationImageViewController

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
    
    imageRadius = self.imageView.bounds.size.width / 2;
    [self.slider setValue:1.0f];
    delta = CGPointMake(12.0f, 4.0f);
    [self startTimerWithTimeInterval:self.slider.value];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showLoading];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0f
                     animations:^{
                         //
                     } completion:^(BOOL finished) {
                         NSData *data = [NSData dataWithContentsOfURL:self.imageURL];
                         UIImage *image = [[UIImage alloc] initWithData:data];
                         self.imageView.image = image;
                         [self hideLoading];
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [timer invalidate];
}

#pragma mark - UISlider Methods

/*
 *  Метод изменяет скорость анимации при изменении позиции регулятора
 */
- (IBAction)sliderMoved:(id)sender
{
    [self startTimerWithTimeInterval:self.slider.value];
}

#pragma mark - NSTimer Methods

/*
 *  Метод запускает таймер
 */
- (void)startTimerWithTimeInterval:(float)timeInterval
{
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                             target:self
                                           selector:@selector(onTimer)
                                           userInfo:nil
                                            repeats:YES];
}

/*
 *  Метод перестраивает позицию изображения
 */
- (void)onTimer
{
    self.imageView.center = CGPointMake(self.imageView.center.x + delta.x, self.imageView.center.y + delta.y);
    
    if (self.imageView.center.x > self.view.bounds.size.width - imageRadius ||
        self.imageView.center.x < imageRadius)
        delta.x = - delta.x;
    
    if (self.imageView.center.y > self.view.bounds.size.height - imageRadius ||
        self.imageView.center.y < imageRadius)
        delta.y = - delta.y;
}

@end
