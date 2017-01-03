//
//  Genre+CoreDataProperties.h
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Genre+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Genre (CoreDataProperties)

+ (NSFetchRequest<Genre *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *index;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Track *> *tracks;

@end

@interface Genre (CoreDataGeneratedAccessors)

- (void)addTracksObject:(Track *)value;
- (void)removeTracksObject:(Track *)value;
- (void)addTracks:(NSSet<Track *> *)values;
- (void)removeTracks:(NSSet<Track *> *)values;

@end

NS_ASSUME_NONNULL_END
