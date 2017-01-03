//
//  GERRequests.h
//  musico
//
//  Created by George Malushkin on 31/12/2016.
//  Copyright © 2016 George Malushkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id responseData);
typedef void (^FailureBlock)(NSError *error);
typedef void (^ProgressBlock)(NSProgress *progress);


@interface GERRequests : NSObject

- (instancetype)initWithHost:(NSString *)host;

#pragma mark - Search
- (void)getTracksForUbiquity:(NSString *)searchString
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure;

#pragma mark - Lookup

#pragma mark - Common
+ (void)downloadFileForURLString:(NSString *)destinationString
                    saveWithName:(NSString *)saveName
                        progress:(ProgressBlock)progress
               completionHandler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))completion;

@end
