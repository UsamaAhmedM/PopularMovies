//
//  Movie.m
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "Movie.h"

@implementation Movie
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"movieID":@"id",
                                                                  @"voteAverage":@"vote_average",
                                                                  @"title": @"title",
                                                                  @"posterPath":@"poster_path",
                                                                  @"originalTitle":@"original_title",
                                                                  @"overview": @"overview",
                                                                  @"releaseDate":@"release_date"}];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.movieID forKey:@"movieID"];
    [aCoder encodeObject:self.voteAverage forKey:@"voteAverage"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.posterPath forKey:@"posterPath"];
    [aCoder encodeObject:self.originalTitle forKey:@"originalTitle"];
    [aCoder encodeObject:self.overview forKey:@"overview"];
    [aCoder encodeObject:self.releaseDate forKey:@"releaseDate"];
    [aCoder encodeObject:self.fav forKey:@"fav"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.movieID=[aDecoder decodeObjectForKey:@"movieID"];
    self.voteAverage=[aDecoder decodeObjectForKey:@"voteAverage"];
    self.title=[aDecoder decodeObjectForKey:@"title"];
    self.posterPath=[aDecoder decodeObjectForKey:@"posterPath"];
    self.originalTitle=[aDecoder decodeObjectForKey:@"originalTitle"];
    self.overview=[aDecoder decodeObjectForKey:@"overview"];
    self.releaseDate=[aDecoder decodeObjectForKey:@"releaseDate"];
    self.fav=[aDecoder decodeObjectForKey:@"fav"];
    return self;
}
@end
