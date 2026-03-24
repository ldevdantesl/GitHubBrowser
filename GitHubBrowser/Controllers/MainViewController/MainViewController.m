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
#import "GHLoadingView.h"
#import "RepositoryCell.h"
#import "NotFoundCell.h"
#import "UICollectionViewCell+Extensions.h"

static const struct {
    CGFloat spacing;
    CGFloat padding;
} Constants = {
    .spacing = 10.0,
    .padding = 16.0
};

@interface MainViewController () <UISearchBarDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) BOOL isSearching;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<GHRepository *> *repositories;
@property (nonatomic, strong) GHLoadingView *loadingView;

@end

@implementation MainViewController

#pragma mark - LAZY PROPERTIES
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = @"Search repositories...";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewCompositionalLayout *layout = [self createLayout];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[RepositoryCell class] forCellWithReuseIdentifier:[RepositoryCell cellIdentifier]];
        [_collectionView registerClass:[NotFoundCell class] forCellWithReuseIdentifier:[NotFoundCell cellIdentifier]];
    }
    return _collectionView;
}

-(GHLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[GHLoadingView alloc] init];
    }
    return _loadingView;
}

#pragma mark - LIFECYCLE
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    [self setupUI];
}

#pragma mark - UI SETUP
- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.trailing.equalTo(self.view);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom).offset(Constants.spacing);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    [self.view addSubview: self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UICollectionViewCompositionalLayout *)createLayout {
    NSCollectionLayoutSize *itemSize = [
        NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
            heightDimension:[NSCollectionLayoutDimension estimatedDimension:1000]];
    
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                                       heightDimension:[NSCollectionLayoutDimension estimatedDimension:60]];
    
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:groupSize subitems:@[item]];
    
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    section.interGroupSpacing = 10;
    section.contentInsets = NSDirectionalEdgeInsetsMake(16, 16, 16, 16);
    
    return [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
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
    [self.loadingView showOnView: self.view];
    [[GHApiClient shared] searchRepositories: searchBar.text completion:^(NSArray *repositories, NSError *error) {
        self.isSearching = true;
        if (error) {
            NSLog(@"Error: %@", error);
            [self.loadingView hide];
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.repositories = repositories;
            [self.collectionView reloadData];
            [self.loadingView hide];
        });
    }];
}

#pragma mark - UI COLLECTION VIEW DATA SOURCE
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.repositories.count > 0 ? self.repositories.count : 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.repositories.count > 0) {
        GHRepository *repo = self.repositories[indexPath.item];
        RepositoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RepositoryCell cellIdentifier] forIndexPath:indexPath];
        [cell configureWithRepository:repo];
        return cell;
    }
    
    NotFoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NotFoundCell cellIdentifier] forIndexPath:indexPath];
    [cell configureForInitialPresentation:!self.isSearching];
    return cell;
}

@end
