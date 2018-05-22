//
//  UpdateFavouriteMoviesArrayProtocol.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
@protocol UpdateFavouriteMoviesArrayProtocol <NSObject>
-(void) UpdateMoviesArray:(NSArray<Movie>*) movies;
@end
