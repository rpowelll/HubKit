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
