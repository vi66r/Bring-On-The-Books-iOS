//
//  HIPlacesManagerDelegate.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HIPlacesManager;
@class HIPlaceDetailsResult;

@protocol HIPlacesManagerDelegate <NSObject>

@optional

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceAutocompleteResultsDidFailWithError:(NSError *)error;
- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceAutocompleteResults:(NSArray *)placeAutocompleteResults;

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceDetailsResultDidFailWithError:(NSError *)error;
- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceDetailsResult:(HIPlaceDetailsResult *)placeDetailsResult;

@end
