//
//  Movie.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol Movie;

@interface Movie : JSONModel <NSCoding>

@property (nonatomic) NSNumber<Optional> *movieID;
@property (nonatomic) NSNumber<Optional> *voteAverage;
@property (nonatomic)  NSString<Optional> *title;
@property (nonatomic)  NSString<Optional> *posterPath;
@property (nonatomic)   NSString<Optional> *originalTitle;
@property (nonatomic)   NSString<Optional> *overview;
@property (nonatomic)   NSString<Optional> *releaseDate;
@property (nonatomic) NSNumber<Ignore> *fav;

@end
