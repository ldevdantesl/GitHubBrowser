//
//  RepositoryCell.h
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import <UIKit/UIKit.h>
#import "GHRepository.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryCell : UICollectionViewCell
    -(void)configureWithRepository: (GHRepository *) repository;
@end

NS_ASSUME_NONNULL_END
