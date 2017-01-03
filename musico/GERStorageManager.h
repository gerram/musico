//
//  GERStorageManager.h
//  musico
//
//  Created by George Malushkin on 02/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GERStorageManager : NSObject

@property (strong) NSManagedObjectContext *mainManagedObjectContext;

+ (instancetype)sharedManager;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;


@end
