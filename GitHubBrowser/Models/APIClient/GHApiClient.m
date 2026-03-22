//
//  GHApiClient.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 22.03.2026.
//

#import "GHApiClient.h"
#import "GHRepository.h"

static NSString * const kBaseURL = @"https://api.github.com";

@implementation GHApiClient

+ (instancetype)shared {
    static GHApiClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GHApiClient alloc] init];
    });
    return instance;
}

- (void)searchRepositories:(NSString *)query
                completion:(void(^)(NSArray *repositories, NSError *error))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/search/repositories?q=%@", kBaseURL, query];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                completion(nil, error);
                return;
            }
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *items = json[@"items"];
            
            NSMutableArray *repos = [NSMutableArray array];
            for (NSDictionary *dict in items) {
                GHRepository *repo = [[GHRepository alloc] initWithDictionary:dict];
                [repos addObject:repo];
            }
            
            completion([repos copy], nil);
    }];
    
    [task resume];
}

@end
