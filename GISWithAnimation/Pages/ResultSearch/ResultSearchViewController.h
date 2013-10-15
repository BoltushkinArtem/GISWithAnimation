//
//  ResultSearchViewController.h
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

/**
 *  Контроллер результатов поиска
 */

#import <UIKit/UIKit.h>

@interface ResultSearchViewController : UICollectionViewController <UICollectionViewDelegate>
{
    NSMutableArray *imagesList;
    NSInteger previousScrollValue;
}

/**
 *  Список словарей, содержащий информацию о изображениях
 */
@property (nonatomic) NSArray *dictionaryImagesList;

/**
 *  Название искомой картинки
 */
@property (nonatomic) NSString *searchImageTitle;

/**
 *  Начальный индекс страницы
 */
@property (nonatomic) NSInteger minPageIndex;

@end
