//
//  Artist+CoreDataProperties.h
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Artist+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Artist (CoreDataProperties)

+ (NSFetchRequest<Artist *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *artist_id;
@property (nullable, nonatomic, copy) NSString *artist_name;
@property (nullable, nonatomic, copy) NSString *artist_view_url;
@property (nullable, nonatomic, copy) NSDate *index;
@property (nullable, nonatomic, retain) NSSet<Track *> *tracks;

@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addTracksObject:(Track *)value;
- (void)removeTracksObject:(Track *)value;
- (void)addTracks:(NSSet<Track *> *)values;
- (void)removeTracks:(NSSet<Track *> *)values;

@end

NS_ASSUME_NONNULL_END
