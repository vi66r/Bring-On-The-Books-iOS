//
//  HIPlacesManager.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HIPlacesManagerDelegate.h"

@class HIPlaceAutocompleteRequest;
@class HIPlaceDetailsRequest;

@interface HIPlacesManager : NSObject

@property (nonatomic, weak) id<HIPlacesManagerDelegate> delegate;

/**
 Searches for PlaceAutocompleteResults based on the request provided
 
 @note The delegate will receive messages if the search
 was successful or not.
 @param request The request used to search for results. The request must contain the key and input.
 @see HIPlacesManagerDelegate
 */
- (void)searchForPlaceAutocompleteResultsWithRequest:(HIPlaceAutocompleteRequest *)request;

/**
 Searches for PlaceDetails based on the request provided
 
 @note The delegate will receive messages if the search
 was successful or not.
 @param request The request used to search for results. The request must contain the key and placeId.
 @see HIPlacesManagerDelegate
 */
- (void)searchForPlaceDetailsResultWithRequest:(HIPlaceDetailsRequest *)request;

@end
