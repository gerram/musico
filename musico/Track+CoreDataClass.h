//
//  Track+CoreDataClass.h
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist, Collection, Genre;

NS_ASSUME_NONNULL_BEGIN

@interface Track : NSManagedObject

- (void)loadFromDictionary:(NSDictionary *)dictionary;

+ (Track *)findOrCreateEntityWithID:(NSNumber *)ID inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Track+CoreDataProperties.h"
