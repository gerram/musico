//
//  GERResultsTableViewCell.h
//  musico
//
//  Created by George Malushkin on 04/01/2017.
//  Copyright © 2017 George Malushkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GERResultsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

- (instancetype)setupFromEntityID:(NSNumber *)trackID;

@end
