//
//  MainViewController.m
//  GitHubBrowser
//
//  Created by Buzurg Rakhimzoda on 21.03.2026.
//

#import "MainViewController.h"
#import <Masonry/Masonry.h>
#import "GHRepository.h"
#import "GHApiClient.h"

static const struct {
    CGFloat spacing;
    CGFloat padding;
} Constants = {
    .spacing = 10.0,
    .padding = 16.0
};

static NSString * const kCellIdentifier = @"RepositoryCell";

@interface MainViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<GHRepository *> *repositories;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation MainViewController

#pragma mark - LAZY PROPERTIES
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"Search repositories...";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: kCellIdentifier];
    }
    return _tableView;
}

-(UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleLarge];
        _activityIndicator.hidesWhenStopped = true;
    }
    return _activityIndicator;
}

#pragma mark - LIFECYCLE
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    [self setupUI];
}

#pragma mark - UI SETUP
- (void)setupUI {
    
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.trailing.equalTo(self.view).inset(Constants.padding);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom).offset(Constants.spacing);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    [self.tableView addSubview: self.activityIndicator];
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
    }];
}

#pragma mark - CONFIG

-(void) initialSetup {
    self.title = @"GitHub Repos";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    self.repositories = @[];
}

#pragma mark - UISEARCH BAR DELEGATE
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.activityIndicator startAnimating];
    [[GHApiClient shared] searchRepositories:searchBar.text
                                  completion:^(NSArray *repositories, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [self.activityIndicator stopAnimating];
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.repositories = repositories;
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
        });
    }];
}

#pragma mark - UI TABLE VIEW DATA SOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                            forIndexPath:indexPath];
    GHRepository *repo = self.repositories[indexPath.row];
    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.repoDescription;
    return cell;
}

#pragma mark - UI TABLE VIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GHRepository *repo = self.repositories[indexPath.row];
    NSLog(@"Selected: %@", repo.fullName);
}

@end
