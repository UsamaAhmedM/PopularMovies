//
//  UpdateMovieFavouriteStateProtocol.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpdateMovieFavouriteStateProtocol <NSObject>
-(void)updateMovie:(Movie*)movie AtIndex:(int)index;
@end
