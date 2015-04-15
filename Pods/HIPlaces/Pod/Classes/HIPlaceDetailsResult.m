//
//  HIPlaceDetailsResult.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 02/02/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlaceDetailsResult.h"
#import "HIPlaceTypes.h"

@implementation HIPlaceDetailsResult

- (id)initWithPlaceDetailsAttributes:(NSDictionary *)placeDetailsAttributes
{
    self = [super init];
    if (self) {
        if (![placeDetailsAttributes objectForKey:@"place_id"]) {
            [[NSException exceptionWithName:NSInvalidArgumentException reason:@"place_id cannot be nil" userInfo:nil] raise];
        }
        _placeId = [placeDetailsAttributes objectForKey:@"place_id"];
        _formattedAddress = [placeDetailsAttributes objectForKey:@"formatted_address"];
        _name = [placeDetailsAttributes objectForKey:@"name"];
        CLLocationDegrees lat = [[[[placeDetailsAttributes objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
        CLLocationDegrees lng = [[[[placeDetailsAttributes objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
        _location = CLLocationCoordinate2DMake(lat, lng);
        
        _placeTypes = [HIPlaceTypes placeTypesForPlaceTypeStrings:[placeDetailsAttributes objectForKey:@"types"]];
    }
    
    return self;
}

@end