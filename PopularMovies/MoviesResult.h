//
//  Result.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "Movie.h"
@protocol MoviesResult;
@interface MoviesResult : JSONModel
@property (nonatomic) NSNumber *page;
@property (nonatomic) NSNumber *totalPages;
@property (nonatomic) NSArray<Movie> *results;
@end

