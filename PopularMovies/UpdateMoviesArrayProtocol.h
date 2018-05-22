//
//  UpdateMoviesArrayProtocol.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
@protocol UpdateMoviesArrayProtocol <NSObject>
@required

-(void) UpdateMoviesArray:(NSArray<Movie>*) movies;
@end
