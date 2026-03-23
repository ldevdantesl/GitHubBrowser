//
//  UICollectionViewCell+Extensions.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UICollectionViewCell (Extensions)

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

@end
