//
//  Collection+CoreDataProperties.h
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Collection+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Collection (CoreDataProperties)

+ (NSFetchRequest<Collection *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *collection_id;
@property (nullable, nonatomic, copy) NSString *collection_name;
@property (nullable, nonatomic, copy) NSString *collection_view_url;
@property (nullable, nonatomic, copy) NSDate *index;
@property (nullable, nonatomic, copy) NSNumber *track_count;
@property (nullable, nonatomic, retain) NSSet<Track *> *tracks;

@end

@interface Collection (CoreDataGeneratedAccessors)

- (void)addTracksObject:(Track *)value;
- (void)removeTracksObject:(Track *)value;
- (void)addTracks:(NSSet<Track *> *)values;
- (void)removeTracks:(NSSet<Track *> *)values;

@end

NS_ASSUME_NONNULL_END
