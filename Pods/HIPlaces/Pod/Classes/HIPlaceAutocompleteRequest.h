//
//  HIPlaceAutocompleteRequest.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "HIPlacesConstants.h"
#import "HIPlaceTypes.h"

@interface HIPlaceAutocompleteRequest : NSObject

@property (nonatomic, copy) NSString *input;
@property (nonatomic, copy) NSString *key;
@property (nonatomic) NSUInteger offset;
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic) NSUInteger radius;
@property (nonatomic) HIPlaceType placeType;

@end
