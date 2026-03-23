//
//  NotFounCell.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import "NotFoundCell.h"
#import "CONSTANTS.h"
#import <Masonry/Masonry.h>

@interface NotFoundCell ()
    @property (nonatomic, strong) UIImageView* imageView;
    @property (nonatomic, strong) UILabel* label;
@end

static const struct {
    CGFloat imageSize;
    CGFloat spacing;
} Constants = {
    .imageSize = 50.0,
    .spacing = 10.0
};

@implementation NotFoundCell

#pragma mark - PROPERTIES
-(UIImageView *) imageView  {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

-(UILabel *) label  {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize: 16 weight: UIFontWeightBold];
        _label.textColor = [UIColor labelColor];
    }
    return _label;
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
    self.label.text = nil;
    self.imageView.image = nil;
}

#pragma mark - PUBLIC FUNC
- (void)configureForInitialPresentation:(BOOL)initialPresentation {
    if (initialPresentation) {
        self.label.text = @"Search For Repository";
        self.imageView.image = CONSTANTS.searchForRepoImage;
    } else {
        self.label.text = @"Repository Not Found";
        self.imageView.image = CONSTANTS.repoNotFoundImage;
    }
}

#pragma mark - PRIVATE FUNC
- (void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Constants.spacing);
        make.left.right.equalTo(self.contentView).inset(Constants.spacing);
        make.height.mas_equalTo(Constants.imageSize);
    }];
    
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(Constants.spacing);
        make.left.right.equalTo(self.contentView).inset(Constants.spacing);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Constants.spacing);
    }];
}

@end
