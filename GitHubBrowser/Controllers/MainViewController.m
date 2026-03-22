//
//  MainViewController.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 21.03.2026.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger counter;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBlueColor];
    self.titleLabel = [[UILabel alloc] init];
}

-(void)setupUI {
    
}

- (void)configureLabel {
    self.titleLabel.text = @"First label";
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
