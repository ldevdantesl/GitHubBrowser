//
//  MainViewController.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 21.03.2026.
//

#import "MainViewController.h"
#import <Masonry/Masonry.h>

static const struct {
    CGFloat spacing;
    CGFloat padding;
} Constants = {
    .spacing = 10.0,
    .padding = 16.0
};

@interface MainViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MainViewController

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"First label";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBlueColor];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.leading.trailing.equalTo(self.view).inset(10);
    }];
}

@end
