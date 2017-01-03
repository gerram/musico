//
//  Track+CoreDataProperties.m
//  musico
//
//  Created by George Malushkin on 04/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Track+CoreDataProperties.h"

@implementation Track (CoreDataProperties)

+ (NSFetchRequest<Track *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Track"];
}

@dynamic artwork_100_uiimage;
@dynamic artwork_url_100;
@dynamic index;
@dynamic release_date;
@dynamic track_id;
@dynamic track_name;
@dynamic track_number;
@dynamic track_preview_url;
@dynamic track_time;
@dynamic track_view_url;
@dynamic artwork_key;
@dynamic artist;
@dynamic collection;
@dynamic primary_genre;

@end
