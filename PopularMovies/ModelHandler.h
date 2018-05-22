//
//  ModelHandler.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateMoviesArrayProtocol.h"
#import "UpdateFavouriteMoviesArrayProtocol.h"
#import "Movie.h"

static const NSString *BYRATING=@"vote_average.desc";
static const NSString *BYPPOPULARITY=@"popularity.desc";

@interface ModelHandler : NSObject<UpdateMoviesArrayProtocol>


@property id<UpdateMoviesArrayProtocol> updateMoviesProtocol;

@property id<UpdateFavouriteMoviesArrayProtocol> UpdateFavouriteMoviesArrayProtocol;

- (id)init UNAVAILABLE_ATTRIBUTE __attribute__((unavailable("You cannot init this class directly. Use sharedInstance to get the singleton Instance")));

+ (id)new UNAVAILABLE_ATTRIBUTE __attribute__((unavailable("You cannot use new this class directly. Use sharedInstance to get the singleton Instance")));

+ (instancetype) sharedInstance;


- (void) getMoviesArrayByFilter:(NSString*)filter;
- (void) addMovieToFavourite : (Movie*) movie;
- (void) removeMovieToFavourite:(Movie*) movie;
-(void)getFavouriteMovies;

@end
