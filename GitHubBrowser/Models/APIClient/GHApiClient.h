//
//  GHApiClient.h
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHApiClient : NSObject

+ (instancetype)shared;

- (void)searchRepositories:(NSString *)query
                completion:(void(^)(NSArray *repositories, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
