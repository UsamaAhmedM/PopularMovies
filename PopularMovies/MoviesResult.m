//
//  Result.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "MoviesResult.h"

@implementation MoviesResult

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperForSnakeCase];
}


@end
