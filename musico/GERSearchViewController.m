//
//  GERSearchViewController.m
//  musico
//
//  Created by George Malushkin on 31/12/2016.
//  Copyright © 2016 George Malushkin. All rights reserved.
//

#import "GERSearchViewController.h"
#import "GERRequests.h"


typedef NS_ENUM(NSUInteger, SearchControllerTableTags)
{
    SearchControllerResultsTableTag = 101,
    SearchControllerPreviousSearchesTableTag = 201,
};

@interface GERSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *previousSearchesTableView;
@property (nonatomic, strong) GERRequests *apiClient;
@property (nonatomic, strong) NSArray *previousSearchesItems;
@property (nonatomic, strong) NSArray *resultsItems;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *previousTVHeightConstraint;

@end

@implementation GERSearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _apiClient = [[GERRequests alloc] initWithHost:@"https://itunes.apple.com/"];
    
    [_apiClient getTracksForUbiquity:@"john+lennon"
                             success:^(id responseData) {
                                 
                             }
                             failure:^(NSError *error) {
                                 //
                             }];
    
    _previousSearchesItems = @[@"john lennon", @"ласковый май"];
    _resultsItems = @[@111, @1234, @23423, @234, @234234];
    
    _previousTVHeightConstraint.constant = 0.0;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)previousSearchesState:(BOOL)state
{
    [self.view layoutIfNeeded];
    
    if (state)
    {
        self.previousTVHeightConstraint.constant = 160.0;
        
        // Dim
        UIView *dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        dimView.tag = 1111;
        dimView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.tableView addSubview:dimView];
        
        self.tableView.scrollEnabled = NO;
    }
    else
    {
        self.previousTVHeightConstraint.constant = 0.0;
        
        // Dim removing
        id dimView = [self.tableView viewWithTag:1111];
        if ([dimView isKindOfClass:[UIView class]])
        {
            [dimView removeFromSuperview];
        }
        
        self.tableView.scrollEnabled = YES;
    }
    
    [UIView animateWithDuration:.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == SearchControllerPreviousSearchesTableTag)
    {
        return self.previousSearchesItems.count;
    }
    else if (tableView.tag == SearchControllerResultsTableTag)
    {
        return self.resultsItems.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == SearchControllerPreviousSearchesTableTag)
    {
        return 34.0;
    }
    
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == SearchControllerResultsTableTag)
    {
        static NSString *cellIdentifier = @"ResultCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    else if (tableView.tag == SearchControllerPreviousSearchesTableTag)
    {
        static NSString *previosSearchesCellIdentifier = @"PreviousSearchesCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:previosSearchesCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.previousSearchesItems[indexPath.row];
        
        return cell;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == SearchControllerPreviousSearchesTableTag)
    {
        return @"Previous searches:";
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == SearchControllerPreviousSearchesTableTag)
    {
        self.searchBar.text = [self.previousSearchesItems[indexPath.row] copy];
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    }
}


#pragma mark - <UISearchBarDelegate>
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self previousSearchesState:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [self previousSearchesState:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0)
    {
        // Clear and lowercase new string
        NSString *clearString = [searchBar.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]].lowercaseString;
        
        if (clearString.length > 0)
        {
            // ResultsTable
            [self searchOnITunes:clearString];
            
            // PreviousSearchesTable.
            // check for existence current text in previous searches
            if ([self.previousSearchesItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF == %@", clearString]].count == 0)
            {
                // add new item to a head of previous searching array
                self.previousSearchesItems = [@[clearString] arrayByAddingObjectsFromArray:self.previousSearchesItems];
                [self.previousSearchesTableView reloadData];
            }
        }
    }
    
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)searchOnITunes:(NSString *)searchString
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@" +"
                                                                               options:NSRegularExpressionCaseInsensitive error:&error];
        NSString *serializedString = [regex stringByReplacingMatchesInString:searchString options:0 range:NSMakeRange(0, searchString.length) withTemplate:@"+"];
        
        [self.apiClient getTracksForUbiquity:serializedString
                                     success:^(NSDictionary *responseData) {
                                         
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             //
                                         });
                                         
                                     } failure:^(NSError *error) {
                                         //
                                     }];
    });
}


- (IBAction)doNext:(id)sender {
    
    
    [self performSegueWithIdentifier:@"SearchToDetail" sender:sender];
}

@end
