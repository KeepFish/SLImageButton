//
//  ImagePositionViewController.m
//  SLImageButton
//
//  Created by 孙立 on 2020/10/24.
//  Copyright © 2020 sl. All rights reserved.
//

#import "ImagePositionViewController.h"

@interface ImagePositionViewController ()

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) ImagePosition position;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ImagePositionViewController

- (instancetype)initWithPosition:(ImagePosition)position {
    if (self = [super init]) {
        _position = position;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title;
    switch (self.position) {
        case ImagePositionNormal:
            title = @"image in left";
            break;
        case ImagePositionTop:
            title = @"image in top";
            break;
        case ImagePositionRight:
            title = @"image in right";
            break;
        case ImagePositionBottom:
            title = @"image in bottom";
            break;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = title;
    [self buildUI];
}

- (void)buildUI {
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = self.view.bounds;
    
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"1. without padding and space";
    label1.frame = CGRectMake(15, 10, 250, 17);
    [self.scrollView addSubview:label1];
    
    CGFloat lastBtnX = 0;
    for (NSInteger i=0; i<self.images.count; i++) {
        UIButton *btn = [self getButtonWithImageName:self.images[i] title:@"title" padding:0 space:0];
        [self.scrollView addSubview:btn];
        [btn sizeToFit];
        btn.frame = CGRectMake(0 + lastBtnX + 15, 40, btn.frame.size.width, btn.frame.size.height);
        lastBtnX = btn.frame.origin.x + btn.frame.size.width;
    }
    
    UILabel *label2 = [UILabel new];
    label2.font = [UIFont systemFontOfSize:15];
    label2.text = @"2. 10 padding";
    label2.frame = CGRectMake(15, 150, 100, 17);
    [self.scrollView addSubview:label2];
    lastBtnX = 0;
    
    // 10 padding
    for (NSInteger i=0; i<self.images.count; i++) {
        UIButton *btn = [self getButtonWithImageName:self.images[i] title:@"title2" padding:10 space:0];
        [self.scrollView addSubview:btn];
        [btn sizeToFit];
        btn.frame = CGRectMake(0 + lastBtnX + 15, 180, btn.frame.size.width, btn.frame.size.height);
        lastBtnX = btn.frame.origin.x + btn.frame.size.width;
    }
    
    UILabel *label3 = [UILabel new];
    label3.font = [UIFont systemFontOfSize:15];
    label3.text = @"3. 10 space";
    label3.frame = CGRectMake(15, 280, 100, 17);
    [self.scrollView addSubview:label3];
    lastBtnX = 0;
    
    // 10 space
    for (NSInteger i=0; i<self.images.count; i++) {
        UIButton *btn = [self getButtonWithImageName:self.images[i] title:@"title3" padding:0 space:10];
        [self.scrollView addSubview:btn];
        [btn sizeToFit];
        btn.frame = CGRectMake(0 + lastBtnX + 15, 310, btn.frame.size.width, btn.frame.size.height);
        lastBtnX = btn.frame.origin.x + btn.frame.size.width;
    }
    
    UILabel *label4 = [UILabel new];
    label4.font = [UIFont systemFontOfSize:15];
    label4.text = @"4. 10 space and 10 padding";
    label4.frame = CGRectMake(15, 410, 200, 17);
    [self.scrollView addSubview:label4];
    lastBtnX = 0;
    
    // 10 space and padding
    for (NSInteger i=0; i<self.images.count; i++) {
        UIButton *btn = [self getButtonWithImageName:self.images[i] title:@"title4" padding:10 space:10];
        [self.scrollView addSubview:btn];
        [btn sizeToFit];
        btn.frame = CGRectMake(0 + lastBtnX + 15, 440, btn.frame.size.width, btn.frame.size.height);
        lastBtnX = btn.frame.origin.x + btn.frame.size.width;
    }

    
    UILabel *label5 = [UILabel new];
    label5.font = [UIFont systemFontOfSize:15];
    label5.text = @"5. no title and 10 padding";
    label5.frame = CGRectMake(15, 550, 200, 17);
    [self.scrollView addSubview:label5];
    lastBtnX = 0;
    
    // 10 space and padding
    for (NSInteger i=0; i<self.images.count; i++) {
        UIButton *btn = [self getButtonWithImageName:self.images[i] title:@"" padding:10 space:10];
        [self.scrollView addSubview:btn];
        [btn sizeToFit];
        btn.frame = CGRectMake(0 + lastBtnX + 15, 580, btn.frame.size.width, btn.frame.size.height);
        lastBtnX = btn.frame.origin.x + btn.frame.size.width;
    }
    
    UILabel *label6 = [UILabel new];
    label6.font = [UIFont systemFontOfSize:15];
    label6.text = @"5. no image and 10 padding";
    label6.frame = CGRectMake(15, 680, 200, 17);
    [self.scrollView addSubview:label6];
    lastBtnX = 0;
    
    // 10 space and padding
    UIButton *btn = [self getButtonWithImageName:@"" title:@"title5" padding:10 space:10];
    [self.scrollView addSubview:btn];
    [btn sizeToFit];
    btn.frame = CGRectMake(0 + lastBtnX + 15, 710, btn.frame.size.width, btn.frame.size.height);
    lastBtnX = btn.frame.origin.x + btn.frame.size.width;
    
    
    UILabel *label7 = [UILabel new];
    label7.font = [UIFont systemFontOfSize:15];
    label7.numberOfLines = 2;
    label7.text = @"4. 10 space and 10 padding with large title and small image";
    label7.frame = CGRectMake(15, 780, 250, 40);
    [self.scrollView addSubview:label7];
    
    // 10 space and padding
    lastBtnX = 0;
    for (NSInteger i=0; i<self.images.count; i++) {
        UIButton *btn = [self getButtonWithImageName:@"mini" title:@"large title" padding:10 space:10];
        [self.scrollView addSubview:btn];
        [btn sizeToFit];
        btn.frame = CGRectMake(0 + lastBtnX + 15, 850, btn.frame.size.width, btn.frame.size.height);
        lastBtnX = btn.frame.origin.x + btn.frame.size.width;
    }

}

- (UIButton *)getButtonWithImageName:(NSString *)imageName title:(NSString *)title padding:(CGFloat)padding space:(CGFloat)space {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    btn.tintColor = nil;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (imageName.length > 0) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [btn sl_setPosition:self.position];
    [btn sl_setSpacing:space padding:padding];
    return btn;
}

- (NSArray *)images {
    if (_images == nil) {
        _images = @[@"small-icon", @"medium-icon", @"large-icon"];
    }
    return _images;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    }
    return _scrollView;
}

@end
