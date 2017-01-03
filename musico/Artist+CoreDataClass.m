//
//  Artist+CoreDataClass.m
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Artist+CoreDataClass.h"
#import "Track+CoreDataClass.h"
@implementation Artist

- (void)loadFromDictionary:(NSDictionary *)dictionary
{
    self.artist_name = dictionary[@"artistName"];
}

+ (Artist *)findOrCreateEntityWithID:(NSNumber *)ID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Artist"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"artist_id = %@", ID];
    
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
        Artist *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Artist"inManagedObjectContext:context];
        entity.artist_id = ID;
        entity.index = [NSDate date];
        
        return entity;
    }
}

@end
