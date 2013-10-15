//
//  RootViewController.h
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

/**
 *  Базовый View-контроллер для *всех* экранов в проекте
 */

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

/**
 *	Сообщение об ошибке
    @param text - текст сообщения
 */
- (void)showError:(NSString*)text;

/**
 *  Индикация спиннера загрузки данных
 */
- (void)showLoading;

/**
 *  Индикация спиннера загрузки данных с текстом
    @param text - текст сообщения
 */
- (void)showLoadingText:(NSString*)text;

/**
 *  Скрытие спиннера загрузки данных
 */
- (void)hideLoading;

@end
