//
//  RepositoryCell.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import "RepositoryCell.h"
#import <Masonry/Masonry.h>
#import "StarsView.h"

@interface RepositoryCell ()
    @property (nonatomic, strong) UILabel* titleLabel;
    @property (nonatomic, strong) UILabel* descriptionLabel;
    @property (nonatomic, strong) UILabel* ownerLabel;
    @property (nonatomic, strong) StarsView* starsView;
    @property (nonatomic, strong) UIView* divider;
@end

static NSInteger const kSpacing = 10;

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

-(UILabel *) descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize: 14 weight: UIFontWeightMedium];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textColor = [UIColor secondaryLabelColor];
    }
    return _descriptionLabel;
}

-(UILabel *) ownerLabel {
    if (!_ownerLabel) {
        _ownerLabel = [[UILabel alloc] init];
        _ownerLabel.font = [UIFont systemFontOfSize: 14 weight: UIFontWeightSemibold];
        _ownerLabel.adjustsFontSizeToFitWidth = true;
        _ownerLabel.textColor = [UIColor darkGrayColor];
    }
    return _ownerLabel;
}

-(StarsView *) starsView {
    if(!_starsView) {
        _starsView = [[StarsView alloc] init];
    }
    return _starsView;
}

-(UIView *) divider {
    if(!_divider) {
        _divider = [[UIView alloc] init];
        _divider.backgroundColor = [[UIColor labelColor] colorWithAlphaComponent:0.4];
    }
    return _divider;
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
    self.descriptionLabel.text = nil;
    self.ownerLabel.text = nil;
    self.titleLabel.text = nil;
    [self.starsView clear];
}

#pragma mark - PUBLIC FUNC
- (void)configureWithRepository:(GHRepository *)repository {
    self.titleLabel.text = repository.name;
    self.descriptionLabel.text = repository.repoDescription;
    self.ownerLabel.text = [NSString stringWithFormat:@"User: %@", repository.owner.login];
    [self.starsView configureWithTotalStars:repository.stars];
}

#pragma mark - PRIVATE FUNC
-(void)setupUI {
    [self.contentView addSubview:self.ownerLabel];
    [self.ownerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kSpacing);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ownerLabel.mas_bottom).offset(kSpacing);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kSpacing);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.starsView];
    [self.starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom).offset(kSpacing);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.divider];
    [self.divider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starsView.mas_bottom).offset(kSpacing);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.contentView).offset(-kSpacing);
    }];
}

@end
