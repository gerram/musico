//
//  Collection+CoreDataClass.m
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Collection+CoreDataClass.h"
#import "Track+CoreDataClass.h"
@implementation Collection

- (void)loadFromDictionary:(NSDictionary *)dictionary
{
    self.collection_name = dictionary[@"collectionName"];
}

+ (Collection *)findOrCreateEntityWithID:(NSNumber *)ID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Collection"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"collection_id = %@", ID];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"error: %@", error.localizedDescription);
    }
    if (result.lastObject)
    {
        return result.lastObject;
    }
    else
    {
        Collection *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Collection" inManagedObjectContext:context];
        entity.collection_id = ID;
        entity.index = [NSDate date];
        
        return entity;
    }
}

@end
