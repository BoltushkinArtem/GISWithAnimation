//
//  ResultSearchViewController.m
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

#import "ResultSearchViewController.h"
#import "ResultSearchCollectionViewCell.h"
#import "AnimationImageViewController.h"
#import "GoogleImageSearchManager.h"

@interface ResultSearchViewController ()

@end

@implementation ResultSearchViewController

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
    
    imagesList = [NSMutableArray new];
    for(NSDictionary *imageInfo in self.dictionaryImagesList){
        NSURL *url = [NSURL URLWithString:[imageInfo objectForKey:@"tbUrl"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [imagesList addObject:data];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewController Delegate Methods

/*
 *  Количество ячеек
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return imagesList.count;
}

/*
 *  Создания ячейки и загрузка в нее данных
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ImageCell";
    ResultSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                     forIndexPath:indexPath];
    
    cell.image = [[UIImage alloc] initWithData:[imagesList objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Navigation Methods

/*
 *  Метод отслеживает переходы
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PushToAnimationImage"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        AnimationImageViewController *animation_image_VC = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        NSDictionary *imageInfo = [self.dictionaryImagesList objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[imageInfo objectForKey:@"url"]];
        animation_image_VC.imageURL = url;
    }
}

@end
