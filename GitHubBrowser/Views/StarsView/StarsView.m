//
//  StarsView.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 23.03.2026.
//

#import "StarsView.h"
#import <Masonry/Masonry.h>

@interface StarsView ()
@property (nonatomic, strong) UIStackView* hStack;
@property (nonatomic, strong) UILabel *starsLabel;
@end

static NSString * const kStarImageName = @"star.fill";
static NSInteger const kStarImageSize = 20;

@implementation StarsView

#pragma mark - PROPERTIES
- (UIStackView *) hStack {
    if (!_hStack) {
        _hStack = [[UIStackView alloc] init];
        _hStack.axis = UILayoutConstraintAxisHorizontal;
        _hStack.distribution = UIStackViewDistributionFill;
        _hStack.alignment = UIStackViewAlignmentCenter;
        _hStack.spacing = 4;
    }
    return _hStack;
}


#pragma mark - LIFECYCLE
- (instancetype)init {
    self = [super initWithFrame: CGRectZero];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype) initWithTotalStars:(NSInteger)stars {
    self = [self init];
    if (self) {
        [self configureWithTotalStars: stars];
    }
    return self;
}

#pragma mark - PUBLIC FUNC
- (void) configureWithTotalStars: (NSInteger) stars {
    [self setupTotalStars: stars];
}

- (void) clear {
    for (UIView *view in self.hStack.arrangedSubviews) {
        [self.hStack removeArrangedSubview:view];
        [view removeFromSuperview];
    }
}

#pragma mark - PRIVATE FUNC
- (void)setupUI {
    [self addSubview: self.hStack];
    [self.hStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.equalTo(self);
    }];
}

- (void)setupTotalStars:(NSInteger)stars {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage systemImageNamed: kStarImageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStarImageSize, kStarImageSize));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize: 14];
    label.text = [self formattedStars:stars];
    label.textColor = [UIColor labelColor];

    [self.hStack addArrangedSubview: imageView];
    [self.hStack addArrangedSubview: label];
}

- (NSString *)formattedStars:(NSInteger)stars {
    if (stars >= 1000000) {
        return [NSString stringWithFormat:@"%.1fM", stars / 1000000.0];
    } else if (stars >= 1000) {
        return [NSString stringWithFormat:@"%.1fk", stars / 1000.0];
    } else {
        return [NSString stringWithFormat:@"%ld", (long)stars];
    }
}

@end
