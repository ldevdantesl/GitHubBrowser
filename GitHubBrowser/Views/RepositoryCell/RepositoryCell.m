//
//  RepositoryCell.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import "RepositoryCell.h"
#import <Masonry/Masonry.h>

@interface RepositoryCell ()
    @property (nonatomic, strong) UILabel* titleLabel;
@end

@implementation RepositoryCell

#pragma mark - PROPERTIES
-(UILabel *) titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 16 weight: UIFontWeightBold];
        _titleLabel.adjustsFontSizeToFitWidth = true;
        _titleLabel.textColor = [UIColor labelColor];
    }
    return _titleLabel;
}

#pragma mark - LIFECYCLE
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
}

#pragma mark - PUBLIC FUNC
- (void)configureWithName:(nonnull NSString *)name {
    self.titleLabel.text = name;
}

#pragma mark - PRIVATE FUNC
-(void)setupUI {
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
}

@end
