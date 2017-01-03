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

@interface GERDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation GERDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.coverView animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = @"Loading";
    //hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    //hud.backgroundView.color = [UIColor grayColor];
    
    //GERRequests *apiClient = [[GERRequests alloc] initWithHost:@"https://itunes.apple.com/"];
    NSString *destinationString = @"http://is1.mzstatic.com/image/thumb/Music2/v4/42/31/f5/4231f540-3615-6f44-ff9f-f993c159bc2b/source/1400x1400bb.jpg";
    //NSString *destinationString = @"http://a1427.phobos.apple.com/us/r30/Music4/v4/f1/38/5e/f1385ec0-e6af-1ed2-4a43-f9810d49c276/mzaf_1365252727233417631.plus.aac.p.m4a";
    
    
     [GERRequests downloadFileForURLString:destinationString progress:^(NSProgress *progress) {
         hud.progressObject = progress;
         //NSLog(@"%lld", progress.completedUnitCount);
     } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
         UIImage *cover = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:filePath]];
         dispatch_async(dispatch_get_main_queue(), ^{
             [hud hideAnimated:YES];
             self.coverImage.image = cover;
         });
     //
     }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
