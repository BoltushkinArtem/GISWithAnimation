//
//  ResultSearchCollectionViewCell.m
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

#import "ResultSearchCollectionViewCell.h"

@interface ResultSearchCollectionViewCell ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation ResultSearchCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImage:(UIImage *)newImage
{
    _image = newImage;
    self.imageView = [UIImageView new];
    self.imageView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.imageView.image = newImage;
    [self addSubview:self.imageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
