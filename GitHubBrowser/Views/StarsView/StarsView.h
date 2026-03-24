//
//  StarsView.h
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 23.03.2026.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StarsView : UIView
-(instancetype) init NS_DESIGNATED_INITIALIZER;
-(instancetype) initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
-(instancetype) initWithFrame:(CGRect)frame NS_UNAVAILABLE;
-(instancetype) initWithTotalStars: (NSInteger) stars;
- (void) configureWithTotalStars: (NSInteger) stars;
- (void) clear;
@end

NS_ASSUME_NONNULL_END
