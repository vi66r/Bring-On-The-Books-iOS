//
//  HIPlacesManager.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlacesManager.h"
#import "HIPlaceAutocompleteRequest.h"
#import "HIPlacesConstants.h"
#import "HIPlaceAutocompleteResult.h"
#import "HIPlaceDetailsRequest.h"
#import "HIPlaceDetailsResult.h"

// 3rd party
#import <AFNetworking/AFNetworking.h>

@implementation HIPlacesManager

- (void)setDelegate:(id<HIPlacesManagerDelegate>)delegate
{
    if (delegate && ![delegate conformsToProtocol:@protocol(HIPlacesManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                reason:@"Delegate object does not conform to HIPlacesManagerDelegate protocol"
                              userInfo:nil] raise];
    }
    _delegate = delegate;
}

- (void)searchForPlaceAutocompleteResultsWithRequest:(HIPlaceAutocompleteRequest *)request
{
    NSParameterAssert(request);
    
    // key cannot be empty or nil
    if (!request.key || [request.key isEqualToString:@""]) {
        [[NSException exceptionWithName:HIInvalidKeyException
                                reason:@"key cannot be nil or empty"
                               userInfo:nil] raise];
    }
    
    // input cannot be empty or nil
    if (!request.input || [request.input isEqualToString:@""]) {
        [[NSException exceptionWithName:HIInvalidInputException
                                 reason:@"input cannot be nil or empty"
                               userInfo:nil] raise];
    }
    
    // The following code isn't unit tested as it depends on a 3rd party library AFNetworking
    NSString *requestURLString = [self placeAutocompleteRequestURLStringFromRequest:request];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:requestURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        if ([self statusCodeForResponse:responseDictionary] == HIGoogleStatusCodeOK) {
            NSArray *placeAutocompleteResults = [self placeAutocompleteResultsForResponse:responseDictionary];
            if ([self.delegate respondsToSelector:@selector(placesManager:didSearchForPlaceAutocompleteResults:)]) {
                [self.delegate placesManager:self didSearchForPlaceAutocompleteResults:placeAutocompleteResults];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(placesManager:searchForPlaceAutocompleteResultsDidFailWithError:)]) {
                NSError *placesManagerError = [NSError errorWithDomain:HIPlacesErrorDomain
                                                                  code:[self placesErrorForGoogleStatusCode:[self statusCodeForResponse:responseDictionary]]
                                                              userInfo:nil];
                [self.delegate placesManager:self searchForPlaceAutocompleteResultsDidFailWithError:placesManagerError];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(placesManager:searchForPlaceAutocompleteResultsDidFailWithError:)]) {
            NSError *placesManagerError = [NSError errorWithDomain:HIPlacesErrorDomain
                                                              code:HIPlacesErrorConnectionFailed
                                                          userInfo:nil];
            [self.delegate placesManager:self searchForPlaceAutocompleteResultsDidFailWithError:placesManagerError];
        }
    }];
}

- (void)searchForPlaceDetailsResultWithRequest:(HIPlaceDetailsRequest *)request
{
    NSParameterAssert(request);
    
    // key cannot be empty or nil
    if (!request.key || [request.key isEqualToString:@""]) {
        [[NSException exceptionWithName:HIInvalidKeyException
                                 reason:@"key cannot be nil or empty"
                               userInfo:nil] raise];
    }
    
    // placeId cannot be empty or nil
    if (!request.placeId || [request.placeId isEqualToString:@""]) {
        [[NSException exceptionWithName:HIInvalidKeyException
                                 reason:@"placeId cannot be nil or empty"
                               userInfo:nil] raise];
    }
    
    // The following code isn't unit tested as it depends on a 3rd party library AFNetworking
    NSString *requestURLString = [self placeDetailsRequestURLStringFromRequest:request];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:requestURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        if ([self statusCodeForResponse:responseDictionary] == HIGoogleStatusCodeOK) {
            HIPlaceDetailsResult *placeDetailsResult = [self placeDetailsResultForResponse:responseDictionary];
            if ([self.delegate respondsToSelector:@selector(placesManager:didSearchForPlaceDetailsResult:)]) {
                [self.delegate placesManager:self didSearchForPlaceDetailsResult:placeDetailsResult];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(placesManager:searchForPlaceDetailsResultDidFailWithError:)]) {
                NSError *placesManagerError = [NSError errorWithDomain:HIPlacesErrorDomain
                                                                  code:[self placesErrorForGoogleStatusCode:[self statusCodeForResponse:responseDictionary]]
                                                              userInfo:nil];
                [self.delegate placesManager:self searchForPlaceDetailsResultDidFailWithError:placesManagerError];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(placesManager:searchForPlaceAutocompleteResultsDidFailWithError:)]) {
            NSError *placesManagerError = [NSError errorWithDomain:HIPlacesErrorDomain
                                                              code:HIPlacesErrorConnectionFailed
                                                          userInfo:nil];
            [self.delegate placesManager:self searchForPlaceDetailsResultDidFailWithError:placesManagerError];
        }
    }];
}

#pragma mark - Helper methods

- (NSString *)placeAutocompleteRequestURLStringFromRequest:(HIPlaceAutocompleteRequest *)request
{
    NSMutableString *requestURLString = [NSMutableString stringWithString:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?"];
    
    request.input = [request.input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [requestURLString appendFormat:@"key=%@&input=%@", request.key, request.input];
    
    if (request.offset != NSNotFound) {
        [requestURLString appendFormat:@"&offset=%lu", (unsigned long)request.offset];
    }
    
    if (request.location.latitude != NSNotFound && request.location.longitude != NSNotFound) {
        if (request.location.latitude <= 90.0 && request.location.latitude >= -90.0 &&
            request.location.longitude <= 180.0 && request.location.longitude >= -180.0) {
            [requestURLString appendFormat:@"&location=%f,%f", request.location.latitude, request.location.longitude];
        } else {
            [[NSException exceptionWithName:HIInvalidLocationException
                                    reason:@"Latitude must be [-90.0, 90.0] & longitude must be [-180.0, 180.0]"
                                  userInfo:nil] raise];
        }
    }
    
    if (request.radius != NSNotFound) {
        [requestURLString appendFormat:@"&radius=%lu", (unsigned long)request.radius];
    }
    
    if (request.placeType != HIPlaceTypeNone) {
        if (request.placeType == HIPlaceTypeGeocode) {
            [requestURLString appendFormat:@"&types=%@", [HIPlaceTypes placeTypeStringForPlaceType:HIPlaceTypeGeocode]];
        } else if (request.placeType == HIPlaceTypeAddress) {
            [requestURLString appendFormat:@"&types=%@", [HIPlaceTypes placeTypeStringForPlaceType:HIPlaceTypeAddress]];
        } else if (request.placeType == HIPlaceTypeEstablishment) {
            [requestURLString appendFormat:@"&types=%@", [HIPlaceTypes placeTypeStringForPlaceType:HIPlaceTypeEstablishment]];
        } else if (request.placeType == HIPlaceTypeRegionsCollection) {
            [requestURLString appendFormat:@"&types=%@", [HIPlaceTypes placeTypeStringForPlaceType:HIPlaceTypeRegionsCollection]];
        } else if (request.placeType == HIPlaceTypeCitiesCollection) {
            [requestURLString appendFormat:@"&types=%@", [HIPlaceTypes placeTypeStringForPlaceType:HIPlaceTypeCitiesCollection]];
        } else {
            [[NSException exceptionWithName:HIInvalidPlaceTypeException
                                     reason:@"PlaceType doesn't belong to list of pre-defined PlaceTypes"
                                   userInfo:nil] raise];
        }
    }
        
    return [requestURLString copy];
}

- (NSString *)placeDetailsRequestURLStringFromRequest:(HIPlaceDetailsRequest *)request
{
    NSMutableString *requestURLString = [NSMutableString stringWithString:@"https://maps.googleapis.com/maps/api/place/details/json?"];
    
    [requestURLString appendFormat:@"key=%@&placeid=%@", request.key, request.placeId];
    
    return [requestURLString copy];
}

- (HIGoogleStatusCode)statusCodeForResponse:(NSDictionary *)responseDictionary
{
    NSString *status = [responseDictionary objectForKey:@"status"];
    if ([status isEqualToString:@"OK"]) {
        return HIGoogleStatusCodeOK;
    } else if ([status isEqualToString:@"ZERO_RESULTS"]) {
        return HIGoogleStatusCodeZeroResults;
    } else if ([status isEqualToString:@"OVER_QUERY_LIMIT"]) {
        return HIGoogleStatusCodeOverQueryLimit;
    } else if ([status isEqualToString:@"REQUEST_DENIED"]) {
        return HIGoogleStatusCodeRequestDenied;
    } else if ([status isEqualToString:@"INVALID_REQUEST"]) {
        return HIGoogleStatusCodeInvalidRequest;
    } else if ([status isEqualToString:@"NOT_FOUND"]) {
        return HIGoogleStatusCodeNotFound;
    } else {
        return HIGoogleStatusCodeUnknownError;
    }
}

- (NSUInteger)placesErrorForGoogleStatusCode:(HIGoogleStatusCode)googleStatusCode
{
    switch (googleStatusCode) {
        case HIGoogleStatusCodeZeroResults:
            return HIPlacesErrorZeroResults;
            break;
            
        case HIGoogleStatusCodeOverQueryLimit:
            return HIPlacesErrorOverQueryLimit;
            break;
            
        case HIGoogleStatusCodeRequestDenied:
            return HIPlacesErrorRequestDenied;
            break;
            
        case HIGoogleStatusCodeInvalidRequest:
            return HIPlacesErrorInvalidRequest;
            break;
            
        case HIGoogleStatusCodeNotFound:
            return HIPlacesErrorNotFound;
            break;
            
        default:
            return HIPlacesErrorUnkownError;
            break;
    }
}

- (NSArray *)placeAutocompleteResultsForResponse:(NSDictionary *)responseDictionary
{
    NSArray *predictions = [responseDictionary objectForKey:@"predictions"];
    NSMutableArray *placeAutocompleteResults = [[NSMutableArray alloc] initWithCapacity:predictions.count];
    
    for (NSDictionary *placeAutocompleteAttributes in predictions) {
        HIPlaceAutocompleteResult *placeAutocompleteResult = [[HIPlaceAutocompleteResult alloc] initWithPlaceAutocompleteAttributes:placeAutocompleteAttributes];
        [placeAutocompleteResults addObject:placeAutocompleteResult];
    }
    
    return [placeAutocompleteResults copy];
}

- (HIPlaceDetailsResult *)placeDetailsResultForResponse:(NSDictionary *)responseDictionary
{
    NSDictionary *placeDetailsAttributes = [responseDictionary objectForKey:@"result"];
    
    HIPlaceDetailsResult *placeDetailsResult = [[HIPlaceDetailsResult alloc] initWithPlaceDetailsAttributes:placeDetailsAttributes];
    return placeDetailsResult;
}

@end
