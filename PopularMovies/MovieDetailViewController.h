//
//  MovieDetailViewController.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "UpdateMovieFavouriteStateProtocol.h"

@interface MovieDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property Movie *movie;
@property int index;
@property id<UpdateMovieFavouriteStateProtocol> updateProtocol;
@end
