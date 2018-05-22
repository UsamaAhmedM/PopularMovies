//
//  DBModel.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
@interface DBModel : NSObject

-(BOOL)insertMovie:(Movie*)movie;

-(BOOL)insertMovies:(NSArray<Movie>*)movies;

-(BOOL)insertFavouriteMovie:(Movie*)movie;

-(NSArray<Movie>*) getStoredMovies;

-(NSArray<Movie>*) getStoredFavouriteMovies;
@end
