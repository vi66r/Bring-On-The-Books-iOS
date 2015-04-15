//
//  HIPlaceDetailsResult.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 02/02/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HIPlaceDetailsResult : NSObject

@property (readonly) NSString *placeId;
@property (readonly) NSString *formattedAddress;
@property (readonly) NSString *name;
@property (readonly) CLLocationCoordinate2D location;
@property (readonly) NSArray *placeTypes;

- (id)initWithPlaceDetailsAttributes:(NSDictionary *)placeDetailsAttributes;

@end
