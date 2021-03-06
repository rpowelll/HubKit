/*
 Copyright (c) 2013 Rhys Powell and Josh Johnson
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "HubKit.h"
#import "HKHTTPClient.h"
#import "HKKeychain.h"
#import "HKAuthorization.h"

@interface HubKit ()

@property (nonatomic, strong, readwrite) HKHTTPClient *httpClient;

@end

@implementation HubKit {}

#pragma mark - Shared Instance

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static HubKit *hk_sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        hk_sharedInstance = [[HubKit alloc] init];
    });
    return hk_sharedInstance;
}

#pragma mark - Properties

- (HKHTTPClient *)httpClient
{
    if (! _httpClient) {
        _httpClient = [[HKHTTPClient alloc] init];
        [_httpClient setAuthorizationHeaderWithToken:[[HKUser currentUser] token]];
    }
    return _httpClient;
}

#pragma mark - Authorization

- (void)setApplicationClientId:(NSString *)clientId
                        secret:(NSString *)clientSecret
               requestedScopes:(NSArray *)scopes
{
    HKAuthorization *authorization = [HKAuthorization new];
    [authorization setClientId:clientId];
    [authorization setClientSecret:clientSecret];
    [authorization setScopes:scopes];
    [self.httpClient setAuthorization:authorization];
}

#pragma mark - GitHub API Authorization

- (void)loginWithUser:(NSString *)username
             password:(NSString *)password
           completion:(HKGenericCompletionHandler)completion
{
    [self.httpClient createAuthorizationWithUsername:username password:password completion:^(id authorizationDictionary, NSError *error) {
        if (error) {
            if (completion) {
                completion(error);
            }
        } else {
            NSString *token = authorizationDictionary[@"token"];
            
            if (token) {
                [HKKeychain storeAuthenticationToken:token userAccount:username];
                [self.httpClient setAuthorizationHeaderWithToken:token];
                
                [self getCurrentUserWithCompletion:^(id userObject, NSError *userError) {
                    if (completion) {
                        completion(userError);
                    }
                }];
            } else {
                NSError *tokenError = [NSError errorWithDomain:kHKHubKitErrorDomain
                                                          code:100
                                                      userInfo:@{ NSLocalizedDescriptionKey : @"Could not find token" }];
                if (completion) {
                    completion(tokenError);
                }
            }
        }
    }];
}

#pragma mark - GitHub API User

- (void)getCurrentUserWithCompletion:(HKObjectCompletionHandler)completion
{
    [self.httpClient getAuthenticatedUserWithCompletion:^(id object, NSError *error) {
        if (! error) {
            HKUser *user = [HKUser objectWithDictionary:object];
            [HKUser setCurrentUser:user];
            [user save];
            
            if (completion) {
                completion(user, nil);
            }
        } else {
            if (completion) {
                completion(nil, error);
            }
        }
    }];
}

#pragma mark - GitHub API Repos

- (void)getCurrentUserReposWithCompletion:(HKArrayCompletionHandler)completion
{
    [self.httpClient getAuthenticatedUserReposWithCompletion:^(NSArray *collection, NSError *error) {
        NSMutableArray *repos = [[NSMutableArray alloc] initWithCapacity:[collection count]];
        [collection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [repos addObject:[HKRepo objectWithDictionary:obj]];
        }];
        
        if (completion) {
            completion(repos, error);
        }
    }];
}

- (void)getCurrentUserStarredReposWithCompletion:(HKArrayCompletionHandler)completion
{
    [self.httpClient getAuthenticatedUserStarredReposWithCompletion:^(NSArray *collection, NSError *error) {
        NSMutableArray *repos = [[NSMutableArray alloc] initWithCapacity:[collection count]];
        [collection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [repos addObject:[HKRepo objectWithDictionary:obj]];
        }];
        
        if (completion) {
            completion(repos, error);
        }
    }];
}

- (void)getRepositoryWithName:(NSString *)repositoryName user:(NSString *)userName completion:(HKObjectCompletionHandler)completion
{
    [self.httpClient getRepositoryWithName:repositoryName user:userName completion:^(id object, NSError *error) {
        HKRepo *repo = [HKRepo objectWithDictionary:object];
        
        if (completion) {
            completion(repo, error);
        }
    }];
}

@end
