//
//  Collection+CoreDataClass.h
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Track;

NS_ASSUME_NONNULL_BEGIN

@interface Collection : NSManagedObject

- (void)loadFromDictionary:(NSDictionary *)dictionary;

+ (Collection *)findOrCreateEntityWithID:(NSNumber *)ID inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Collection+CoreDataProperties.h"
