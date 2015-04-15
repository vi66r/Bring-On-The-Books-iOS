# HIPlaces

[![CI Status](http://img.shields.io/travis/Hozefa Indorewala/HIPlaces.svg?style=flat)](https://travis-ci.org/Hozefa Indorewala/HIPlaces)
[![Version](https://img.shields.io/cocoapods/v/HIPlaces.svg?style=flat)](http://cocoadocs.org/docsets/HIPlaces)
[![License](https://img.shields.io/cocoapods/l/HIPlaces.svg?style=flat)](http://cocoadocs.org/docsets/HIPlaces)
[![Platform](https://img.shields.io/cocoapods/p/HIPlaces.svg?style=flat)](http://cocoadocs.org/docsets/HIPlaces)

An Objective - C wrapper for the [Google Places API][1]. The library currently includes

1. [Place Autocomplete][2]
2. [Place Details][3]

## Requirements

You will need a valid Google API key which you can obtain from the [Google Developers Console][4]. Once you have a key, replace the "YOUR_KEY_HERE" string in HIPlaceAutocompleteViewController.m & HIPlaceDetailsTableViewController.m with your Google API key.

## Usage

### Example
To run the HIPlacesExample project, clone the repo, and run `pod install` from the HIPlaces directory first. Don't forget to replace the "YOUR_KEY_HERE" string in HIPlaceAutocompleteViewController.m & HIPlaceDetailsTableViewController.m with your Google API key. If you don't have one then obtain one from the [Google Developers Console][4].

<table>
    <tr>
        <td>
            <img src="http://hozefaindorewala.com/images/HIPlacesExample_PlaceAutocomplete.png" width="320" alt="HIPlacesExample PlaceAutocomplete"/>
        </td>
        <td>
            <img src="http://hozefaindorewala.com/images/HIPlacesExample_PlaceDetails.png" width="320" alt="HIPlacesExample PlaceDetails"/>
        </td>
    </tr>
</table>

### API

#### 1. Import HIPlaces
```objective-c
#import <HIPlaces/HIPlaces.h>
```

#### 2. Set up HIPlacesManager
```objective-c
HIPlacesManager *_placesManager = [[HIPlacesManager alloc] init];
_placesManager.delegate = self;
```

#### 3. Create and perform PlaceAutocomplete or PlaceDetails requests
```objective-c
HIPlaceAutocompleteRequest *placeAutocompleteRequest = [[HIPlaceAutocompleteRequest alloc] init];
placeAutocompleteRequest.key = @"YOUR_KEY_HERE";
placeAutocompleteRequest.input = @"Paris";
[_placesManager searchForPlaceAutocompleteResultsWithRequest:placeAutocompleteRequest];

HIPlaceDetailsRequest *placeDetailsRequest = [[HIPlaceDetailsRequest alloc] init];
placeDetailsRequest.key = @"YOUR_KEY_HERE";
placeDetailsRequest.placeId = @"ChIJD7fiBh9u5kcRYJSMaMOCCwQ";
[_placesManager searchForPlaceDetailsResultWithRequest:placeDetailsRequest];
```

#### 4. Set up HIPlacesManagerDelegate protocol methods to handle results
```objective-c
- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceAutocompleteResults:(NSArray *)placeAutocompleteResults
{
    # Do stuff with placeAutocompleteResults
}

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceAutocompleteResultsDidFailWithError:(NSError *)error
{
    # Handle error
}

- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceDetailsResult:(HIPlaceDetailsResult *)placeDetailsResult
{
    # Do stuff with placeDetailsResult
}

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceDetailsResultDidFailWithError:(NSError *)error
{
    # Handle error
}
```

## Installation

HIPlaces is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "HIPlaces"

## Author

Hozefa Indorewala, me@hozefaindorewala.com

## License

HIPlaces is available under the MIT license. See the LICENSE file for more info.


[1]: https://developers.google.com/places/documentation/
[2]: https://developers.google.com/places/documentation/autocomplete
[3]: https://developers.google.com/places/documentation/details
[4]: https://console.developers.google.com
