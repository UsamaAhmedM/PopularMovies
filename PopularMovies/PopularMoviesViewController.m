//
//  FirstViewController.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//
#define SCREENSIZE  [[UIScreen mainScreen] bounds].size
#define IMAGEWIDTH (SCREENSIZE.width/2)-5
#define IMAGEHEIGHT (SCREENSIZE.height/2)-40
#import "PopularMoviesViewController.h"
#import "ModelHandler.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieDetailViewController.h"
@interface PopularMoviesViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)highRatedBtnAction:(id)sender;
- (IBAction)popularbtnAction:(id)sender;

@end

@implementation PopularMoviesViewController
{
    ModelHandler *model;
    NSMutableArray<Movie*> *moviesArray;
    NSString *userFilter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    model=[ModelHandler sharedInstance];
    model.updateMoviesProtocol=self;
    moviesArray=[NSMutableArray new];
    userFilter=BYPPOPULARITY;
    [model getMoviesArrayByFilter:userFilter];
    
}


-(void) UpdateMoviesArray:(NSArray<Movie>*) movies{
    [moviesArray addObjectsFromArray:movies];
    [self.collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailViewController *moviesDetailView=[self.storyboard instantiateViewControllerWithIdentifier:@"detailsView"];
    moviesDetailView.movie=moviesArray[indexPath.item];
    moviesDetailView.index=(int)indexPath.item;
    moviesDetailView.updateProtocol=self;
    moviesDetailView.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:moviesDetailView animated:YES completion:nil];
}

-(void)updateMovie:(Movie*)movie AtIndex:(int)index{
    [moviesArray replaceObjectAtIndex:index withObject:movie];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if(moviesArray.count>indexPath.item)
    {
        
    UIImageView *image=[cell viewWithTag:1];
    image.frame=CGRectMake(0,0,IMAGEWIDTH,IMAGEHEIGHT);
        if(![[moviesArray objectAtIndex:indexPath.item].posterPath containsString:@"null"])
        {
        [image sd_setImageWithURL:[NSURL URLWithString:
                                        [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@",
                                         [moviesArray objectAtIndex:indexPath.item].posterPath]]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                     [cell setNeedsLayout];
                 }];
        }
        else
        {
            image.image=[UIImage imageNamed:@"noposter.jpeg"];
        }
    }
    
    if(moviesArray.count-5==indexPath.item){
        [model getMoviesArrayByFilter:userFilter];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return moviesArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(IMAGEWIDTH,IMAGEHEIGHT );
}
- (IBAction)highRatedBtnAction:(id)sender {
    if ([_titleLabel.text isEqualToString:@"Popular Movies"]) {
        
   [ moviesArray removeObjectsInRange:(NSRange){0,[moviesArray count]}];
    _titleLabel.text=@"HighRated Movies";
     userFilter=BYRATING;
    [self.collectionView setContentOffset:CGPointZero animated:YES];
    [model getMoviesArrayByFilter:BYRATING];
}}

- (IBAction)popularbtnAction:(id)sender {
    if ([_titleLabel.text isEqualToString:@"HighRated Movies"]) {
    [ moviesArray removeObjectsInRange:(NSRange){0,[moviesArray count]}];
     _titleLabel.text=@"Popular Movies";
        
        [self.collectionView setContentOffset:CGPointZero animated:YES];
     userFilter=BYPPOPULARITY;
    [model getMoviesArrayByFilter:BYPPOPULARITY];
    }}
@end
