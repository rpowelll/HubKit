//
//  HKRepo.h
//  HubKit-iOS-Sample
//
//  Created by Rhys Powell on 30/01/13.
//  Copyright (c) 2013 HubKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "HKRemoteManagedObject.h"

@class HKUser;

@interface HKRepo : HKRemoteManagedObject

@property (nonatomic, retain) NSNumber *fork;
@property (nonatomic, retain) NSNumber *forkCount;
@property (nonatomic, retain) NSString *homepage;
@property (nonatomic, retain) NSString *info;
@property (nonatomic, retain) NSString *language;
@property (nonatomic, retain) NSString *masterBranch;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *openIssueCount;
@property (nonatomic, retain) NSNumber *isPrivate;
@property (nonatomic, retain) NSDate *pushedAt;
@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, retain) NSNumber *watcherCount;
@property (nonatomic, retain) NSNumber *hasWiki;
@property (nonatomic, retain) NSNumber *hasIssues;
@property (nonatomic, retain) NSNumber *hasDownloads;
@property (nonatomic, retain) HKUser *owner;

@end
