//
//  UIButton+ImagePosition.m
//  verification-terminal
//
//  Created by 孙立 on 2019/4/4.
//  Copyright © 2019 topode. All rights reserved.
//

#import "UIButton+ImagePosition.h"
#import <objc/runtime.h>

@interface UIButton (ImagePositionPrivate)

@property (nonatomic, assign) ImagePosition sl_currentPosition;

@end

@implementation UIButton (ImagePosition)

- (void)sl_setPosition:(ImagePosition)position {
    self.sl_currentPosition = position;
}

- (void)sl_setSpacing:(CGFloat)spacing {
    [self sl_setSpacing:spacing padding:0];
}

- (void)sl_setPadding:(CGFloat)padding {
    [self sl_setSpacing:0 padding:padding];
}

- (void)sl_setSpacing:(CGFloat)spacing padding:(CGFloat)padding {
    [self sl_setSpacing:spacing padding:padding size:CGSizeZero];
}

- (void)sl_setSpacing:(CGFloat)spacing padding:(CGFloat)padding size:(CGSize)size {
    CGSize selfSize = size;
    
    self.imageEdgeInsets = UIEdgeInsetsZero;
    self.titleEdgeInsets = UIEdgeInsetsZero;
    self.contentEdgeInsets = UIEdgeInsetsZero;
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        [self sizeToFit];
        selfSize = self.bounds.size;
    }
    
    // 移动距离 label跟imageView各来一半
    CGFloat actualSpacing = spacing / 2.f;
    CGSize imageSize = self.currentImage.size;
    
    [self.titleLabel sizeToFit];
    CGSize titleSize = self.titleLabel.frame.size;
    
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleInsets = UIEdgeInsetsZero;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    
    // 如果没有图片 那么有padding就设置好padding就行
    if (CGSizeEqualToSize(imageSize, CGSizeZero) || CGSizeEqualToSize(titleSize, CGSizeZero)) {
        self.contentEdgeInsets = contentInsets;
        [self sizeToFit];
        return;
    }
    
    // image和titleLabel在y轴变换位置时移动距离
    CGFloat imageVerticalMovingDistance;
    CGFloat titleVerticalMovingDistance;
    
    // 需要扩张的高度
    CGFloat buttonTopOffset;
    CGFloat buttonBottomOffset;
    bool imageHeightLargeThanTitleHeight = imageSize.height > titleSize.height;
    if (imageHeightLargeThanTitleHeight) {
        imageVerticalMovingDistance = titleSize.height + spacing;
        titleVerticalMovingDistance = selfSize.height - titleSize.height;
    } else {
        imageVerticalMovingDistance = imageSize.height + spacing;
        titleVerticalMovingDistance = 0;
    }
    
    buttonTopOffset = imageVerticalMovingDistance + padding;
    buttonBottomOffset = padding;
    
    //    UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    switch (self.sl_currentPosition) {
        case ImagePositionNormal: {
            // 这里是设置内部控件排列方式 横向布局就从左开始 下面竖着布局contentVerticalAlignment就设置为top
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            // 这里的数值 跟约束值是一样的 如left 5 距左边距离为5往右偏移  left -5 距左边距离-5 即往左偏移
            // 设置对称值 如left = -5 right 5 是为了不让imageView和label压缩
            imageInsets = UIEdgeInsetsMake(0, -actualSpacing, 0, actualSpacing);
            titleInsets = UIEdgeInsetsMake(0, actualSpacing, 0, -actualSpacing);
            contentInsets.left += actualSpacing;
            contentInsets.right += actualSpacing;
        }
            break;
        case ImagePositionTop: {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            
            imageInsets = UIEdgeInsetsMake(-imageVerticalMovingDistance, 0.5 * (selfSize.width - imageSize.width), imageVerticalMovingDistance, -0.5 * (selfSize.width - imageSize.width));
            titleInsets = UIEdgeInsetsMake(titleVerticalMovingDistance, -0.5 * (selfSize.width - titleSize.width), -titleVerticalMovingDistance, 0.5 * (selfSize.width - titleSize.width));
            // 移动之后的宽度
            CGFloat afterMoveWith = selfSize.width - MIN(imageSize.width, titleSize.width);
            contentInsets = UIEdgeInsetsMake(buttonTopOffset, -0.5 * (selfSize.width - afterMoveWith) + padding, buttonBottomOffset, -0.5 * (selfSize.width - afterMoveWith) + padding);
        }
            break;
        case ImagePositionBottom: {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
            
            imageInsets = UIEdgeInsetsMake(imageVerticalMovingDistance, 0.5 * (selfSize.width - imageSize.width), -imageVerticalMovingDistance, -0.5 * (selfSize.width - imageSize.width));
            titleInsets = UIEdgeInsetsMake(-titleVerticalMovingDistance, -0.5 * (selfSize.width - titleSize.width), titleVerticalMovingDistance, 0.5 * (selfSize.width - titleSize.width));
            // 移动之后的宽度
            CGFloat afterMoveWith = selfSize.width - MIN(imageSize.width, titleSize.width);
            contentInsets = UIEdgeInsetsMake(buttonBottomOffset, -0.5 * (selfSize.width - afterMoveWith) + padding, buttonTopOffset, -0.5 * (selfSize.width - afterMoveWith) + padding);
        }
            break;
        case ImagePositionRight: {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//            if (imageHeightLargeThanTitleHeight) {
                imageInsets = UIEdgeInsetsMake(0, titleSize.width + actualSpacing, 0, -(titleSize.width + actualSpacing));
//            }
            titleInsets = UIEdgeInsetsMake(0, -(imageSize.width + actualSpacing), 0, imageSize.width + actualSpacing);
            contentInsets.left += actualSpacing;
            contentInsets.right += actualSpacing;
        }
            break;
    }
    self.imageEdgeInsets = imageInsets;
    self.titleEdgeInsets = titleInsets;
    self.contentEdgeInsets = contentInsets;
    [self sizeToFit];
}

- (void)setSl_currentPosition:(ImagePosition)currentPosition {
    objc_setAssociatedObject(self, @selector(sl_currentPosition), @(currentPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ImagePosition)sl_currentPosition {
    ImagePosition type = [objc_getAssociatedObject(self, @selector(sl_currentPosition)) integerValue];
    if (!type) {
        type = ImagePositionNormal;
    }
    return type;
}

@end
