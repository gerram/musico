//
//  Track+CoreDataProperties.h
//  musico
//
//  Created by George Malushkin on 04/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Track+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Track (CoreDataProperties)

+ (NSFetchRequest<Track *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *artwork_100_uiimage;
@property (nullable, nonatomic, copy) NSString *artwork_url_100;
@property (nullable, nonatomic, copy) NSDate *index;
@property (nullable, nonatomic, copy) NSDate *release_date;
@property (nullable, nonatomic, copy) NSNumber *track_id;
@property (nullable, nonatomic, copy) NSString *track_name;
@property (nullable, nonatomic, copy) NSNumber *track_number;
@property (nullable, nonatomic, copy) NSString *track_preview_url;
@property (nullable, nonatomic, copy) NSNumber *track_time;
@property (nullable, nonatomic, copy) NSString *track_view_url;
@property (nullable, nonatomic, copy) NSString *artwork_key;
@property (nullable, nonatomic, retain) Artist *artist;
@property (nullable, nonatomic, retain) Collection *collection;
@property (nullable, nonatomic, retain) Genre *primary_genre;

@end

NS_ASSUME_NONNULL_END
