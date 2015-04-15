//
//  HIPlaceAutocompleteRequest.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlaceAutocompleteRequest.h"

@implementation HIPlaceAutocompleteRequest

- (id)init
{
    self = [super init];
    if (self) {
        _offset = NSNotFound;
        _location = CLLocationCoordinate2DMake(NSNotFound, NSNotFound);
        _radius = NSNotFound;
        _placeType = HIPlaceTypeNone;
    }
    return self;
}

@end
