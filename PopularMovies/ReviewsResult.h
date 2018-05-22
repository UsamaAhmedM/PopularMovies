//
//  ReviewsResult.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MovieReview.h"
@protocol ReviewsResult
@end
@interface ReviewsResult : JSONModel
@property (nonatomic)   NSArray<MovieReview> *results;
@end
