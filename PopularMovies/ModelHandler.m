//
//  ModelHandler.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "ModelHandler.h"
#import "NetworkModel.h"
#import "DBModel.h"
@implementation ModelHandler
{
    NetworkModel *networkModel;
    DBModel *dbModel;
    NSUserDefaults *userDefaults;
    BOOL firstHitFlag;
}

+(instancetype)sharedInstance
{
    static ModelHandler *modelHandler=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        modelHandler=[[ModelHandler alloc]initPrivate];});
    return modelHandler;
}
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        networkModel=[NetworkModel new];
        dbModel=[DBModel new];
        networkModel.updateMoviesProtocol=self;
        userDefaults=[NSUserDefaults standardUserDefaults];
        firstHitFlag=YES;
    }
    return self;
}

- (void) getMoviesArrayByFilter:(NSString*)filter{
    if(firstHitFlag)
    {
    if ([userDefaults valueForKey:@"firstTime"]==nil) {
        [networkModel getpopularMoviesOrderdBy:filter Page:1];
    }
    else{
        [self UpdateMoviesArray:[dbModel getStoredMovies]];
    }
    }
    else{
        [networkModel getpopularMoviesOrderdBy:filter Page:0];
    }
    
}
-(void) UpdateMoviesArray:(NSArray<Movie>*) movies
{
    if(firstHitFlag)
    {
      if ([userDefaults valueForKey:@"firstTime"]==nil)
      {
          //save to DB
          [dbModel insertMovies:movies];
          [userDefaults setObject:@"false" forKey:@"firstTime"];
          [userDefaults synchronize];
      }
    firstHitFlag = NO;
    }
    
    [self.updateMoviesProtocol UpdateMoviesArray:movies];
}

- (void) addMovieToFavourite : (Movie*) movie
{
    [dbModel insertMovie:movie];
}
- (void) removeMovieToFavourite:(Movie*) movie
{
    [dbModel insertMovie:movie];
}
-(void)getFavouriteMovies
{
    [_UpdateFavouriteMoviesArrayProtocol UpdateMoviesArray: [dbModel getStoredFavouriteMovies]];
}
@end
