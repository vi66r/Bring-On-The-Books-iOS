//
//  HIPlaceAutocompleteResult.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 22/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlaceAutocompleteResult.h"
#import "HIPlaceTypes.h"

@implementation HIPlaceAutocompleteResult

- (id)initWithPlaceAutocompleteAttributes:(NSDictionary *)placeAutocompleteAttributes
{
    self = [super init];
    if (self) {
        if (![placeAutocompleteAttributes objectForKey:@"place_id"]) {
            [[NSException exceptionWithName:NSInvalidArgumentException reason:@"place_id cannot be nil" userInfo:nil] raise];
        }
        _placeId = [placeAutocompleteAttributes objectForKey:@"place_id"];
        _placeDescription = [placeAutocompleteAttributes objectForKey:@"description"];
        
        _placeTypes = [HIPlaceTypes placeTypesForPlaceTypeStrings:[placeAutocompleteAttributes objectForKey:@"types"]];
    }
    
    return self;
}

@end
