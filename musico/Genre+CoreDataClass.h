//
//  Genre+CoreDataClass.h
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Track;

NS_ASSUME_NONNULL_BEGIN

@interface Genre : NSManagedObject

- (void)loadFromDictionary:(NSDictionary *)dictionary;

+ (Genre *)findOrCreateEntityWithID:(NSString *)ID inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Genre+CoreDataProperties.h"
