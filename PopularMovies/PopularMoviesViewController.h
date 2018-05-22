//
//  FirstViewController.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateMoviesArrayProtocol.h"
#import "UpdateMovieFavouriteStateProtocol.h"
@interface PopularMoviesViewController : UIViewController <UICollectionViewDelegate,
                                                           UICollectionViewDataSource,
                                                           UICollectionViewDelegateFlowLayout,
                                                           UpdateMoviesArrayProtocol,
                                                           UpdateMovieFavouriteStateProtocol>


@end

