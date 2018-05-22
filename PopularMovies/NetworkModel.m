//
//  NetworkModel.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "NetworkModel.h"
#import "AFHTTPSessionManager.h"
#import "MoviesResult.h"
@implementation NetworkModel
static int pageNum=2;
static int MAXPAGENUM=10;
static NSString *lastFilter;

-(void) getpopularMoviesOrderdBy:(NSString*)orderFilter Page:(int)page
{
    if(!lastFilter)
    {lastFilter=orderFilter;
    }
    else if(![lastFilter isEqualToString:orderFilter])
    {
        pageNum=1;
        lastFilter=orderFilter;
    }
    if(page ==1)
        pageNum=1;
    if(pageNum<MAXPAGENUM)
    {
    NSString *urlStr=[NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=a0b4c26b42a560e8a8e6d09fcd386002&language=en-US&sort_by=%@&include_adult=false&include_video=true&page=%d",orderFilter,pageNum++];
        
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSError *err;
        MoviesResult *result = [[MoviesResult alloc] initWithDictionary:responseObject error:&err];
        MAXPAGENUM=[result.totalPages intValue];
        [self.updateMoviesProtocol UpdateMoviesArray:result.results];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    }
}
@end
