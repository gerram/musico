//
//  GERRequests.m
//  musico
//
//  Created by George Malushkin on 31/12/2016.
//  Copyright © 2016 George Malushkin. All rights reserved.
//

#import "GERRequests.h"
#import <AFNetworking.h>

@interface GERRequests ()
@property (nonatomic, strong) AFHTTPSessionManager *managerGET;
@property (nonatomic, assign) NSUInteger fieldsLimit;
@property (nonatomic, copy) NSString *fieldsMedia;
@end

@implementation GERRequests

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithHost:(NSString *)host
{
    if (host.length > 0)
    {
        self = [super init];
        if (self)
        {
            _fieldsLimit = 200; // max amount of items in response results 1 to 200
            _fieldsMedia = @"music"; // movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
            NSURL *hostURL = [NSURL URLWithString:host];
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            _managerGET = [[AFHTTPSessionManager alloc] initWithBaseURL:hostURL sessionConfiguration:configuration];
            _managerGET.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            // Request
            AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];
            [requestSerializer setValue:@"Musico client, ios" forHTTPHeaderField:@"User-Agent"];
            _managerGET.requestSerializer = requestSerializer;
            
            // Response
            AFJSONResponseSerializer *responseSerializer = [[AFJSONResponseSerializer alloc] init];
            responseSerializer.removesKeysWithNullValues = YES;
            _managerGET.responseSerializer = responseSerializer;
        }
        return self;
    }
    return nil;
}

#pragma mark - Search
- (void)getTracksForUbiquity:(NSString *)searchString
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure
{
    if (searchString.length > 0)
    {
        NSString *path = @"search";
        
        NSDictionary *parameters = @{@"term": searchString,
                                     @"limit": @(self.fieldsLimit),
                                     @"media": self.fieldsMedia};
        
        [self.managerGET GET:path
                  parameters:parameters progress:^(NSProgress *downloadProgress) {
                      //
                  }
                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                         if (success)
                         {
                             success(responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         if (failure)
                         {
                             failure(error);
                         }
                     }];
    }
}

#pragma mark - Lookup

#pragma mark - Common
+ (void)downloadFileForURLString:(NSString *)destinationString
                    saveWithName:(NSString *)saveName
                        progress:(ProgressBlock)progress
               completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completion
{
    if (destinationString.length > 0)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:destinationString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
            if (progress)
            {
                return progress(downloadProgress);
            }
        } destination:^NSURL* (NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            
            if (saveName.length)
            {
                return [documentsDirectoryURL URLByAppendingPathComponent:saveName];
            }
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%u_%@", arc4random(), [response suggestedFilename]]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            if (completion)
            {
                return completion(response, filePath, error);
            }
        }];
        [downloadTask resume];
    }
}

@end
