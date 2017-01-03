//
//  GERResultsTableViewCell.m
//  musico
//
//  Created by George Malushkin on 04/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "GERResultsTableViewCell.h"
#import "GERStorageManager.h"
#import "GERRequests.h"
#import "Track+CoreDataClass.h"
#import "Artist+CoreDataClass.h"
#import "Collection+CoreDataClass.h"

@interface GERResultsTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthPreviewCellConstraints;
@end

@implementation GERResultsTableViewCell

- (instancetype)setupFromEntityID:(NSNumber *)trackID
{
    Track *track = [Track findOrCreateEntityWithID:trackID inContext:[GERStorageManager sharedManager].mainManagedObjectContext];
    self.titleLabel.text = track.artist.artist_name;
    self.subtitleLabel.text = [NSString stringWithFormat:@"album: %@, song: %@", track.collection.collection_name, track.track_name];
    
    if (track.artwork_100_uiimage)
    {
        [self previewImageStateOn:YES];
        UIImage *coverPreview = [[UIImage alloc] initWithData:track.artwork_100_uiimage];
        self.previewImage.image = coverPreview;
    }
    else
    {
        [self previewImageStateOn:NO];
        self.previewImage.image = nil;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [GERRequests downloadFileForURLString:track.artwork_url_100
                                     saveWithName:nil
                                         progress:^(NSProgress *progress) {
                                             //
                                         }
                                completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                    NSData *imageData = [NSData dataWithContentsOfURL:filePath];
                                    UIImage *cover = [[UIImage alloc] initWithData:imageData];
                                    
                                    [[NSFileManager defaultManager] removeItemAtURL:filePath error:&error];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        track.artwork_100_uiimage = imageData;
                                        [self previewImageStateOn:YES];
                                        self.previewImage.image = cover;
                                        [self setNeedsLayout];
                                    });
                                    
                                }];
        });
    }
    
    return self;
}

- (void)previewImageStateOn:(BOOL)state
{
    [self layoutIfNeeded];
    
    if (state)
    {
        self.widthPreviewCellConstraints.constant = 50.0;
    }
    else
    {
        self.widthPreviewCellConstraints.constant = 0.0;
    }
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}


@end
