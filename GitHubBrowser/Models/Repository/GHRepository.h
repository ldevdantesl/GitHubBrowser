//
//  GHRepository.h
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import <Foundation/Foundation.h>
#import "GHOwner.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHRepository : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *repoDescription;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, strong) GHOwner *owner;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
