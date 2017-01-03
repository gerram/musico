//
//  GERDetailViewController.m
//  musico
//
//  Created by George Malushkin on 01/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import "GERDetailViewController.h"
#import <MBProgressHUD.h>
#import "GERRequests.h"
#import "Track+CoreDataClass.h"
#import "Artist+CoreDataClass.h"
#import "Genre+CoreDataClass.h"
#import "Collection+CoreDataClass.h"
#import "GERStorageManager.h"

@interface GERDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *labelArtist;
@property (weak, nonatomic) IBOutlet UILabel *labelAlbum;
@property (weak, nonatomic) IBOutlet UILabel *labelTrack;
@property (weak, nonatomic) IBOutlet UILabel *labelRelease;
@property (weak, nonatomic) IBOutlet UILabel *labelGenre;
@end

@implementation GERDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Track *track = [Track findOrCreateEntityWithID:_trackID inContext:[GERStorageManager sharedManager].mainManagedObjectContext];
    [self screenLabelsSetup:track];
    [self screenImageSetup:track];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)screenLabelsSetup:(Track *)track
{
    _labelArtist.text = track.artist.artist_name.length ? [NSString stringWithFormat:@"Artist: %@", track.artist.artist_name] : @"Artist:";
    _labelAlbum.text = track.collection.collection_name.length ? [NSString stringWithFormat:@"Album: %@", track.collection.collection_name] : @"Album:";
    _labelTrack.text = track.track_name.length ? [NSString stringWithFormat:@"Song: %@", track.track_name] : @"Song:";
    
    _labelGenre.text = track.primary_genre.name.length ? [NSString stringWithFormat:@"Genre: %@", track.primary_genre.name] : @"Genre:";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    NSString *releaseText = [formatter stringFromDate:track.release_date];
    _labelRelease.text = releaseText.length ? [NSString stringWithFormat:@"Release date: %@", releaseText] : @"Release date:";
    
}

- (void)screenImageSetup:(Track *)track
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.coverView animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = @"Loading";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *coverFileURL = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", track.artwork_key]];
        
        // 1. File existence
        NSError *error = nil;
        if ([coverFileURL checkResourceIsReachableAndReturnError:&error])
        {
            UIImage *cover = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:coverFileURL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                self.coverImage.image = cover;
            });
        }
        else
        {
            // 2. File downloading
            NSURL *url = [NSURL URLWithString:track.artwork_url_100];
            NSURL *baseURL = [url URLByDeletingLastPathComponent];
            
            CGFloat scale = [UIScreen mainScreen].scale;
            NSString *destinationFileName = nil;
            
            if (scale <= 1.0)
            {
                destinationFileName = @"500x500bb.jpg";
            }
            else if (scale == 2.0)
            {
                destinationFileName = @"1000x1000bb.jpg";
            }
            else if (scale >= 3.0)
            {
                destinationFileName = @"1500x1500bb.jpg";
            }
            
            url = [baseURL URLByAppendingPathComponent:destinationFileName];
            
            [GERRequests downloadFileForURLString:url.absoluteString
                                     saveWithName:[NSString stringWithFormat:@"%@.jpg", track.artwork_key]
                                         progress:^(NSProgress *progress) {
                                             hud.progressObject = progress;
                                         }
                                completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                    UIImage *cover = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:filePath]];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [hud hideAnimated:YES];
                                        self.coverImage.image = cover;
                                    });
                                }];
        }
   
    });
}

@end
