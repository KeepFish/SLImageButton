//
//  ViewController.m
//  SLImageButton
//
//  Created by 孙立 on 2020/10/24.
//  Copyright © 2020 sl. All rights reserved.
//

#import "ViewController.h"
#import "ImagePositionViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"image in left";
    }
    // 上下排布时padding看起来不对是因为label本身就会比文字高一点
    if (indexPath.row == 1) {
        cell.textLabel.text = @"image in top";
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"image in bottom";
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"image in right";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[ImagePositionViewController alloc] initWithPosition:indexPath.row + 1];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"123"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
