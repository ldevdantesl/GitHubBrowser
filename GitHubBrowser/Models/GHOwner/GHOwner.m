//
//  GHOwner.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 23.03.2026.
//

#import "GHOwner.h"

@implementation GHOwner

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _login = dict[@"login"] ?: @"";
        _avatarURL = dict[@"avatar_url"] ?: @"";
    }
    return self;
}

@end
