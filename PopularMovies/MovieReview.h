//
//  MovieDetail.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol MovieReview
@end
@interface MovieReview : JSONModel

@property (nonatomic) NSString *author;
@property (nonatomic) NSString *content;


@end

