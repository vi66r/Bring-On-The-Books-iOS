//
//  HIPlacesConstants.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 22/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>

///--------------------------------------
/// @name Exceptions
///--------------------------------------

extern NSString * const HIInvalidKeyException;
extern NSString * const HIInvalidInputException;
extern NSString * const HIInvalidLocationException;
extern NSString * const HIInvalidPlaceTypeException;

///--------------------------------------
/// @name Errors
///--------------------------------------

extern NSString * const HIPlacesErrorDomain;

typedef NS_ENUM(NSUInteger, HIPlacesError){
    HIPlacesErrorZeroResults,
    HIPlacesErrorOverQueryLimit,
    HIPlacesErrorRequestDenied,
    HIPlacesErrorInvalidRequest,
    HIPlacesErrorNotFound,
    HIPlacesErrorUnkownError,
    HIPlacesErrorInvalidJSON,
    HIPlacesErrorConnectionFailed
};

///--------------------------------------
/// @name Enumerations
///--------------------------------------

typedef NS_ENUM(NSUInteger, HIGoogleStatusCode){
    HIGoogleStatusCodeOK,
    HIGoogleStatusCodeUnknownError,
    HIGoogleStatusCodeZeroResults,
    HIGoogleStatusCodeOverQueryLimit,
    HIGoogleStatusCodeRequestDenied,
    HIGoogleStatusCodeInvalidRequest,
    HIGoogleStatusCodeNotFound
};

