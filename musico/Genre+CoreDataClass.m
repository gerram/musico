//
//  Genre+CoreDataClass.m
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Genre+CoreDataClass.h"
#import "Track+CoreDataClass.h"
@implementation Genre

- (void)loadFromDictionary:(NSDictionary *)dictionary
{
}

+ (Genre *)findOrCreateEntityWithID:(NSString *)ID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Genre"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == %@", ID];
    
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
        Genre *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Genre" inManagedObjectContext:context];
        entity.name = ID;
        entity.index = [NSDate date];
        
        return entity;
    }
}

@end
