//
//  GoogleImageSearchManager.h
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

/**
 *  Класс синглтон, выполняющий обмен данными с сервисом Google Image Search
 */

typedef void (^ArrayResponseBlock)(NSArray* data);
typedef void (^ErrorResponseBlock)(NSError *error);

#import <Foundation/Foundation.h>

@interface GoogleImageSearchManager : NSObject
{
    NSMutableArray *dataArray;
    int answerNumder;
    int requestNumder;
}

/**
 *  Метод возвращает синглтон класса
 */
+ (GoogleImageSearchManager*)instance;

/**
 *	Метод выполняет поиск изображения
    @param imageTitle - Название искомого изображения
 */
- (void)searchImageWithTitle:(NSString*)imageTitle
                   pageIndex:(int)pageIndex
                onCompletion:(ArrayResponseBlock)completionBlock
                     onError:(ErrorResponseBlock)errorBlock;

/**
 *	Метод выполняет поиск изображений с указанием интервала страничных индексов
    @param imageTitle - Название искомого изображения
    @param minPageIndex - Начальный индекс страницы
    @param maxPageIndex - Конечный индекс страницы
 */
- (void)searchImageWithTitle:(NSString*)imageTitle
                minPageIndex:(int)minPageIndex
                maxPageIndex:(int)maxPageIndex
                onCompletion:(ArrayResponseBlock)completionBlock
                     onError:(ErrorResponseBlock)errorBlock;

@end
