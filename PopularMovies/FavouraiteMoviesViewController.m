//
//  SecondViewController.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#define SCREENSIZE  [[UIScreen mainScreen] bounds].size
#define IMAGEWIDTH (SCREENSIZE.width/2)-5
#define IMAGEHEIGHT (SCREENSIZE.height/2)-40

#import "FavouraiteMoviesViewController.h"
#import "ModelHandler.h"
#import "MovieDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FavouraiteMoviesViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FavouraiteMoviesViewController

{
    ModelHandler *model;
    NSMutableArray<Movie*> *moviesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    model=[ModelHandler sharedInstance];
    model.UpdateFavouriteMoviesArrayProtocol=self;
    moviesArray=[NSMutableArray new];
    [model getFavouriteMovies];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [model getFavouriteMovies];
}

-(void) UpdateMoviesArray:(NSArray<Movie>*) movies{
    [moviesArray removeObjectsInRange:(NSRange){0,[moviesArray count]}];
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
    
    if([movie.fav isEqualToNumber:[NSNumber numberWithInt:0]])
    
        [moviesArray removeObjectAtIndex:index ];
    else
        [moviesArray addObject:movie];
    
    
    [self.collectionView reloadData];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if(moviesArray.count>indexPath.item)
    {
        NSLog(@"\n image path %@", [moviesArray objectAtIndex:indexPath.item].posterPath);
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


@end
