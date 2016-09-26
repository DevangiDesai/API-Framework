//
//  RestaurantBean.m
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "RestaurantBeanMap.h"
#import "YokoAPIUtils.h"
#import "LocationBean.h"

@implementation RestaurantBeanMap
@synthesize restaurantName = _restaurantName;
@synthesize locationBean = _locationBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id) initWithJson:(NSDictionary *)json
{
    self = [super init];

    if (self != nil)
    {
        [self loadJSON:json];
    }

    return self;
}


/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 */
- (void) loadJSON:(NSDictionary *)json
{
    self.restaurantName = [YokoAPIUtils stringCheckInDictionary:json key:@"name"];
    NSDictionary *location = [json objectForKey:@"location"];
    self.locationBean = [[LocationBean alloc] initWithJson:location];
}


@end
