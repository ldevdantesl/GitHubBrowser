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
        _name = [self stringOrEmpty:dict[@"name"]];
        _fullName = [self stringOrEmpty:dict[@"full_name"]];
        _repoDescription = [self stringOrEmpty:dict[@"description"]];
        _stars = [dict[@"stargazers_count"] integerValue];
        _owner = [[GHOwner alloc] initWithDictionary:dict[@"owner"]];
    }
    return self;
}

- (NSString *)stringOrEmpty:(id)value {
    if (value && value != [NSNull null]) {
        return value;
    }
    return @"";
}
@end

