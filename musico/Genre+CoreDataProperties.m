//
//  Genre+CoreDataProperties.m
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Genre+CoreDataProperties.h"

@implementation Genre (CoreDataProperties)

+ (NSFetchRequest<Genre *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Genre"];
}

@dynamic index;
@dynamic name;
@dynamic tracks;

@end
