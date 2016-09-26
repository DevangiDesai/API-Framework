//
//  MapBean.m
//  YokoMobile
//
//  Created by Devangi on 12/12/12.
//  Copyright (c) 2012 Glam Media. All rights reserved.
//

#import "LocationBean.h"
#import "YokoAPIUtils.h"

@implementation LocationBean

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
    self.restaurantLatitude = [YokoAPIUtils stringCheckInDictionary:json key:@"lat"];
    self.restaurantLongitude = [YokoAPIUtils stringCheckInDictionary:json key:@"lng"];
    self.resturantAddress = [YokoAPIUtils stringCheckInDictionary:json key:@"address"];
}


@end
