//
//  MovieTrailer.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol MovieTrailer
@end
@interface MovieTrailer : JSONModel

@property (nonatomic)   NSString *key;
@property (nonatomic)   NSString *name;
@end
