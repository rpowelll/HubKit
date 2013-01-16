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

#import "HKManagedObject.h"

@interface HKRemoteManagedObject : HKManagedObject

@property (nonatomic, strong) NSNumber *remoteID;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

+ (instancetype)objectWithRemoteID:(NSNumber *)remoteID;
+ (instancetype)objectWithRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context;

+ (instancetype)existingObjectWithRemoteID:(NSNumber *)remoteID;
+ (instancetype)existingObjectWithRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context;

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context;

+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context;

// Override these in your subclass
- (void)unpackDictionary:(NSDictionary *)dictionary;
- (BOOL)shouldUnpackDictionary:(NSDictionary *)dictionary;

+ (NSDate *)parseDate:(id)dateStringOrDateNumber;

@end