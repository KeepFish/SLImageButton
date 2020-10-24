//
//  UIButton+ImagePosition.h
//  verification-terminal
//
//  Created by 孙立 on 2019/4/4.
//  Copyright © 2019 topode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImagePosition) {
    /** 正常图片在左文字在右 */
    ImagePositionNormal = 1,
    /** 图片在上 */
    ImagePositionTop,
    /** 图片在下 */
    ImagePositionBottom,
    /** 图片在右 */
    ImagePositionRight,
};
@interface UIButton (ImagePosition)

/** 当前图片位置 */
@property (nonatomic, assign, readonly) ImagePosition sl_currentPosition;

/** 要先设置type */
- (void)sl_setPosition:(ImagePosition)position;
/** 设置文字与图片间距 */
- (void)sl_setSpacing:(CGFloat)spacing;
/** 内边距 */
- (void)sl_setPadding:(CGFloat)padding;

- (void)sl_setSpacing:(CGFloat)spacing padding:(CGFloat)padding;

/** size 实际展示的大小 */
- (void)sl_setSpacing:(CGFloat)spacing padding:(CGFloat)padding size:(CGSize)size;

@end
