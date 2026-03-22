//
//  GHLoadingView.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import "GHLoadingView.h"

@interface GHLoadingView ()
    @property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation GHLoadingView

#pragma mark - PROPERTIES
-(UIActivityIndicatorView *) activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] init];
        _activityIndicator.hidesWhenStopped = true;
    }
    return _activityIndicator;
}

#pragma mark - PUBLIC FUNC
- (void) showInVC:(UIViewController *) vc {
    
}

-(void) hide {
    
}

@end
