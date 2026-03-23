//
//  RepositoryCell.h
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryCell : UICollectionViewCell
    -(void)configureWithName: (NSString *) name;
@end

NS_ASSUME_NONNULL_END
