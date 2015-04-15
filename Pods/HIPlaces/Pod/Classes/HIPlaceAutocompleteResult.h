//
//  HIPlaceAutocompleteResult.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 22/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HIPlaceAutocompleteResult : NSObject

@property (readonly) NSString *placeDescription;
@property (readonly) NSString *placeId;
@property (readonly) NSArray *placeTypes;

- (id)initWithPlaceAutocompleteAttributes:(NSDictionary *)placeAutocompleteAttributes;

@end
