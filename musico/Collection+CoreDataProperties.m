//
//  Collection+CoreDataProperties.m
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Collection+CoreDataProperties.h"

@implementation Collection (CoreDataProperties)

+ (NSFetchRequest<Collection *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Collection"];
}

@dynamic collection_id;
@dynamic collection_name;
@dynamic collection_view_url;
@dynamic index;
@dynamic track_count;
@dynamic tracks;

@end
