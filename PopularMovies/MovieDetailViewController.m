//
//  MovieDetailViewController.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPSessionManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieReview.h"
#import "ReviewsResult.h"
#import "TrailerResult.h"
#import "MovieTrailer.h"
#import "ModelHandler.h"
#define SCREENSIZE  [[UIScreen mainScreen] bounds].size
@interface MovieDetailViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationBarWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationTitle;


@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *favouriteBtn;
@property (weak, nonatomic) IBOutlet UITableView *reviewsTableView;
@property (weak, nonatomic) IBOutlet UITableView *trailersTableView;

- (IBAction)markFavoriteBtnAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@end
@implementation MovieDetailViewController
{
    ModelHandler *model;
    NSMutableArray<MovieReview*> *reviewsArray;
    NSMutableArray<MovieTrailer*> *trailersArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    model =[ModelHandler sharedInstance];
    reviewsArray=[NSMutableArray new];
    trailersArray=[NSMutableArray new];

    
    
    if (self.movie) {
        
    
        NSString *urlStr=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=a0b4c26b42a560e8a8e6d09fcd386002",self.movie.movieID];
        
        NSString *urlStr1=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/reviews?api_key=a0b4c26b42a560e8a8e6d09fcd386002&language=en-US&page=1",self.movie.movieID];
        
        NSString *urlStr2=[NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%@/videos?api_key=a0b4c26b42a560e8a8e6d09fcd386002",self.movie.movieID];
        
       
        // get Duration
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
           if(![responseObject[@"runtime"] isMemberOfClass:[NSNull class]])
            self.movieDurationLabel.text=[NSString stringWithFormat:@"%@ min",
                                                                     responseObject[@"runtime"]];
          [self showDetails];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self showDetails];
            NSLog(@"Error: %@", error);
        }];
        
        // get reviews
        AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
        [manager1 GET:urlStr1 parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSError *err;
            ReviewsResult *result = [[ReviewsResult alloc] initWithDictionary:responseObject error:&err];
            [reviewsArray addObjectsFromArray:result.results];
            self.reviewsTableView.hidden=NO;
            [self.reviewsTableView reloadData];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        //get trailers
        
        AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
        [manager1 GET:urlStr2 parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSError *err;
            TrailerResult *result = [[TrailerResult alloc] initWithDictionary:responseObject error:&err];
            [trailersArray addObjectsFromArray:result.results];
            self.trailersTableView.hidden=NO;
            [self.trailersTableView reloadData];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    
}
-(void) showDetails
{
    
    NSLog(@"\n image path %@", self.movie.posterPath);
    
    if(![self.movie.posterPath containsString:@"null"])
    {
        
        [self.moviePoster sd_setImageWithURL: [NSURL URLWithString:
                                               [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@",
                                                self.movie.posterPath]]
                            placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else
    {
        self.moviePoster.image=[UIImage imageNamed:@"noposter.jpeg"];
    }

    
    
    if(self.movie.title !=nil)
    self.navigationTitle.title=self.movie.title;
    
    if(! [self.movie.voteAverage isMemberOfClass:[NSNull class]])
    if([NSString stringWithFormat:@"%@",self.movie.voteAverage].length>3)
    self.rankingLabel.text=[NSString stringWithFormat:@"%@/10",[[NSString stringWithFormat:@"%@",self.movie.voteAverage] substringToIndex:3 ]];
    else
        self.rankingLabel.text=[NSString stringWithFormat:@"%@/10",[NSString stringWithFormat:@"%@",self.movie.voteAverage]];
    
    if(self.movie.releaseDate !=nil &&self.movie.releaseDate.length>3)
    {
    self.yearLabel.text=[self.movie.releaseDate substringToIndex:4];
    }
    if(self.movie.overview!=nil&&![self.movie.overview isEqualToString:@""])
    self.overviewLabel.text=self.movie.overview;
    else
    self.overviewLabel.text=@"There's no available info about the movie";
    
    
    
    if([_movie.fav isEqualToNumber:[NSNumber numberWithInt:0]]||_movie.fav ==nil)
        [_favouriteBtn setTitle:@"Add to Favoutites" forState:UIControlStateNormal];
    else
        [_favouriteBtn setTitle:@"Remove From Favoutites" forState:UIControlStateNormal];
    [self.favouriteBtn setHidden:NO];
}
- (IBAction)markFavoriteBtnAction:(id)sender {
    if([_movie.fav isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _movie.fav=[NSNumber numberWithInt:1];
        [_favouriteBtn setTitle:@"Remove From Favoutites" forState:UIControlStateNormal];
    }
    else
    {
        _movie.fav=[NSNumber numberWithInt:0];
       [_favouriteBtn setTitle:@"Add to Favoutites" forState:UIControlStateNormal];
    }
    [model addMovieToFavourite:_movie];
    [_updateProtocol updateMovie:_movie AtIndex:_index];
}

- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma  mark -table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView== self.reviewsTableView) {

    return reviewsArray.count;
    }
    else
        return trailersArray.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView== self.reviewsTableView) {

    if(reviewsArray.count>0)
    {
        return @"Reviews";
    }
    else
    {
        return @"No Reviews Yet!!";
    }}
else
{
    if(trailersArray.count>0)
    {
        return @"Trailers";
    }
    else
    {
        return @"No available trailer !!";
    }
}}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (tableView== self.reviewsTableView) {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    if (reviewsArray.count>0) {
        UILabel *authorLabel=[cell viewWithTag:1];
        UILabel *reviewContent=[cell viewWithTag:2];
        authorLabel.preferredMaxLayoutWidth = SCREENSIZE.width-100;
        authorLabel.text=[NSString stringWithFormat:@"%@ :",reviewsArray[indexPath.row].author ];
        reviewContent.text=reviewsArray[indexPath.row].content;
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
    }
    
    return cell;
     }
     else{
           UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"trailerCell"];
         if (trailersArray.count>0) {
             UILabel *trailerLabel=[cell viewWithTag:1];
             UIWebView *trailerVideo=[cell viewWithTag:2];
             trailerLabel.text=trailersArray[indexPath.item].name;
             
             trailerVideo.layer.borderWidth = 1.0;
             trailerVideo.layer.borderColor = [UIColor redColor].CGColor;
             
             trailerVideo.backgroundColor = [UIColor blackColor];
             
             trailerVideo.center = self.view.center;
             
             NSString* embedHTML = @"\
             <html><head>\
             <style type=\"text/css\">\
             body {\
             background-color: transparent;\
             color: white;\
             }\
             </style>\
             </head><body style=\"margin:0\">\
             <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
             width=\"%0.0f\" height=\"%0.0f\"></embed>\
             </body></html>";
             
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",trailersArray[indexPath.item].key]];
             
             NSString* html = [NSString stringWithFormat:embedHTML, url, trailerVideo.frame.size.width, trailerVideo.frame.size.height];
             
             [trailerVideo loadHTMLString:html baseURL:nil];
         }
             
         
         
         
         return cell;
     }
}


@end
