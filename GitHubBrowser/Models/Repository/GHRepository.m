//
//  GHRepository.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import "GHRepository.h"

@implementation GHRepository

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _name = dict[@"name"];
        _fullName = dict[@"full_name"];
        _repoDescription = dict[@"description"];
        _stars = [dict[@"stargazers_count"] integerValue];
    }
    return self;
}

@end

