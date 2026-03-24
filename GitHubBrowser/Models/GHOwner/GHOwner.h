//
//  GHOwner.h
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 23.03.2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHOwner : NSObject

@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *avatarURL;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
