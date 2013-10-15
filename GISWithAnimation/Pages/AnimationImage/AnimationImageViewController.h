//
//  AnimationImageViewController.h
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

/**
 *  Класс анимации изображения
 */

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AnimationImageViewController : RootViewController
{
    CGPoint delta;
    NSTimer *timer;
    double imageRadius;
}

/**
 *  Ссылка изображения для анимации
 */
@property (nonatomic) NSURL *imageURL;

@end
