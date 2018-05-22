//
//  SecondViewController.h
//  PopularMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateFavouriteMoviesArrayProtocol.h"
#import "UpdateMovieFavouriteStateProtocol.h"
@interface FavouraiteMoviesViewController : UIViewController<UICollectionViewDelegate,
                                                             UICollectionViewDataSource,
                                                             UICollectionViewDelegateFlowLayout,
                                                             UpdateMovieFavouriteStateProtocol,
                                                             UpdateFavouriteMoviesArrayProtocol>


@end

