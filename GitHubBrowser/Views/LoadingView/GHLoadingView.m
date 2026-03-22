//
//  GHLoadingView.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import "GHLoadingView.h"
#import "CONSTANTS.h"
#import <Masonry/Masonry.h>

@interface GHLoadingView ()
    @property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
    @property (nonatomic, strong) UIImageView *imageView;
    @property (nonatomic, strong) UILabel *loadingLabel;
    @property (nonatomic, strong) UIStackView *vStack;
@end

static const struct {
    CGFloat spacing;
    CGFloat padding;
    CGFloat imageSize;
} Constants = {
    .spacing = 10.0,
    .padding = 16.0,
    .imageSize = 100.0
};

@implementation GHLoadingView

#pragma mark - PROPERTIES
-(UIActivityIndicatorView *) activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] init];
        _activityIndicator.hidesWhenStopped = true;
    }
    return _activityIndicator;
}

-(UIImageView *) imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [CONSTANTS appLogo];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

-(UILabel *)loadingLabel {
    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.text = @"Loading...";
        _loadingLabel.font = [UIFont systemFontOfSize: 16 weight: UIFontWeightBold];
        _loadingLabel.adjustsFontSizeToFitWidth = true;
    }
    return _loadingLabel;
}

-(UIStackView *)vStack {
    if (!_vStack) {
        _vStack = [[UIStackView alloc] initWithArrangedSubviews: @[self.imageView, self.loadingLabel, self.activityIndicator]];
        _vStack.axis = UILayoutConstraintAxisVertical;
        _vStack.distribution = UIStackViewDistributionFill;
        _vStack.alignment = UIStackViewAlignmentCenter;
        _vStack.spacing = 10;
    }
    return _vStack;
}

#pragma mark - LIFECYCLE
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - PUBLIC FUNC
- (void)showOnView:(UIView *)superView {
    self.alpha = 0.0;
    [superView addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    // Fade in
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self startFloatingAnimation];
    }];
    
    [self.activityIndicator startAnimating];
}

- (void)hide {
    [self stopFloatingAnimation];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.activityIndicator stopAnimating];
        [self removeFromSuperview];
    }];
}

#pragma mark - ANIMATION
- (void)startFloatingAnimation {
    [UIView animateWithDuration:0.8 delay:0.0 options:
    UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
    animations:^{
        self.vStack.transform = CGAffineTransformMakeTranslation(0, -8);
    } completion: nil];
}

- (void)stopFloatingAnimation {
    [self.vStack.layer removeAllAnimations];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.vStack.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - PRIVATE FUNC
-(void) setupUI {
    self.alpha = 0;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.5];
    [self addSubview: self.vStack];
    [self.vStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self).inset(Constants.padding);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vStack).priority(MASLayoutPriorityDefaultHigh);
        make.size.mas_equalTo(CGSizeMake(Constants.imageSize, Constants.imageSize)).priority(MASLayoutPriorityDefaultHigh);
    }];
}

@end
