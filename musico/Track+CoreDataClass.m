//
//  Track+CoreDataClass.m
//  musico
//
//  Created by George Malushkin on 03/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "Track+CoreDataClass.h"
#import "Artist+CoreDataClass.h"
#import "Collection+CoreDataClass.h"
#import "Genre+CoreDataClass.h"
#import "GERStorageManager.h"
#import "NSString+MD5.h"

@implementation Track

- (void)loadFromDictionary:(NSDictionary *)dictionary
{
    self.track_name = dictionary[@"trackName"];
    
    //TODO: Maybe to make one formatter for decrasing inits?
    // stringDate @"1996-01-30T08:00:00Z"
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSString *dateString = dictionary[@"releaseDate"];
    self.release_date = [formatter dateFromString:dateString];
    
    self.track_number = dictionary[@"trackNumber"];
    self.track_preview_url = dictionary[@"previewUrl"];
    self.track_view_url = dictionary[@"trackViewUrl"];
    self.track_time = dictionary[@"trackTimeMillis"];
    
    self.artwork_url_100 = dictionary[@"artworkUrl100"];
    NSURL *url = [NSURL URLWithString:self.artwork_url_100];
    NSURL *baseURL = [url URLByDeletingLastPathComponent];
    NSString *baseURLhash = [baseURL.absoluteString MD5];
    self.artwork_key = baseURLhash;
    
    // Artist
    NSNumber *artistID = dictionary[@"artistId"];
    if (artistID)
    {
        Artist *artist = [Artist findOrCreateEntityWithID:artistID inContext:self.managedObjectContext];
        [artist loadFromDictionary:dictionary];
        self.artist = artist;
    }
    
    // Collection
    NSNumber *collectionID = dictionary[@"collectionId"];
    if (collectionID)
    {
        Collection *collection = [Collection findOrCreateEntityWithID:collectionID inContext:self.managedObjectContext];
        [collection loadFromDictionary:dictionary];
        self.collection = collection;
    }
    
    // Genre
    NSString *genreID = dictionary[@"primaryGenreName"];
    if (genreID.length)
    {
        Genre *genre = [Genre findOrCreateEntityWithID:genreID inContext:self.managedObjectContext];
        self.primary_genre = genre;
    }
    
    
}

+ (Track *)findOrCreateEntityWithID:(NSNumber *)ID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Track"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"track_id = %@", ID];
    
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
        Track *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Track" inManagedObjectContext:context];
        entity.track_id = ID;
        entity.index = [NSDate date];
        
        return entity;
    }
}

@end
