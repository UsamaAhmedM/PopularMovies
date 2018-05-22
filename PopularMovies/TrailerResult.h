//
//  TrailerResult.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MovieTrailer.h"
@protocol TrailerResult
@end
@interface TrailerResult : JSONModel
@property (nonatomic, nullable, copy)   NSArray<MovieTrailer> *results;
@end
