//
//  MovieDetail.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "MovieReview.h"

@implementation MovieReview

+ (JSONKeyMapper *)keyMapper
{
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"author": @"author",
                                                                  @"content": @"content",
                                                                 }];
}
@end
