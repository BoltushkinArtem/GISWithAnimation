//
//  ImageSearchViewController.h
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

/**
 *  Контроллер для ввода названия искомого изображения
 */

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ImageSearchViewController : RootViewController <UITextFieldDelegate>
{
    NSMutableArray *resultImageArray;
}

@end
