//
//  HKRepo.m
//  HubKit-iOS-Sample
//
//  Created by Rhys Powell on 30/01/13.
//  Copyright (c) 2013 HubKit. All rights reserved.
//

#import "HKRepo.h"
#import "HKUser.h"
#import "NSDictionary+HKExtensions.h"

@implementation HKRepo

@dynamic isFork;
@dynamic forkCount;
@dynamic homepage;
@dynamic info;
@dynamic language;
@dynamic masterBranch;
@dynamic name;
@dynamic openIssueCount;
@dynamic isPrivate;
@dynamic pushedAt;
@dynamic size;
@dynamic watcherCount;
@dynamic hasWiki;
@dynamic hasIssues;
@dynamic hasDownloads;
@dynamic owner;

+ (NSString *)entityName
{
    return @"Repo";
}

- (void)unpackDictionary:(NSDictionary *)dictionary
{
    [super unpackDictionary:dictionary];
    
    self.name           = [dictionary safeObjectForKey:@"name"];
    self.info           = [dictionary safeObjectForKey:@"description"];
    self.isPrivate      = [dictionary safeObjectForKey:@"private"];
    self.isFork         = [dictionary safeObjectForKey:@"fork"];
    self.homepage       = [dictionary safeObjectForKey:@"homepage"];
    self.language       = [dictionary safeObjectForKey:@"language"];
    self.forkCount      = [dictionary safeObjectForKey:@"forks"];
    self.watcherCount   = [dictionary safeObjectForKey:@"watchers"];
    self.size           = [dictionary safeObjectForKey:@"size"];
    self.masterBranch   = [dictionary safeObjectForKey:@"master_branch"];
    self.openIssueCount = [dictionary safeObjectForKey:@"open_issues"];
    self.hasIssues      = [dictionary safeObjectForKey:@"has_issues"];
    self.hasWiki        = [dictionary safeObjectForKey:@"has_wiki"];
    self.hasDownloads   = [dictionary safeObjectForKey:@"has_downloads"];
    self.pushedAt       = [HKRepo parseDate:[dictionary safeObjectForKey:@"pushed_at"]];
    
    if ([dictionary safeObjectForKey:@"owner"]) {
        self.owner = [HKUser objectWithDictionary:dictionary[@"owner"]];
    }
}

@end
