//
//  Artist+CoreDataProperties.m
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Artist+CoreDataProperties.h"

@implementation Artist (CoreDataProperties)

+ (NSFetchRequest<Artist *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Artist"];
}

@dynamic artist_id;
@dynamic artist_name;
@dynamic artist_view_url;
@dynamic index;
@dynamic tracks;

@end
