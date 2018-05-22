//
//  NetworkModel.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateMoviesArrayProtocol.h"


@interface NetworkModel : NSObject
@property id<UpdateMoviesArrayProtocol> updateMoviesProtocol;
-(void) getpopularMoviesOrderdBy:(NSString*)orderFilter Page:(int)page;

@end
