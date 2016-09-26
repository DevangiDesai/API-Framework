//
//  RecipeJSONParser.m
//  YokoMobile
//
//  Created by Glam on 17/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "RestaurantJsonParser.h"

@implementation RestaurantJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns restaurant object.
 */
+ (RestaurantBean *) parseJSON:(NSDictionary *)data
{
    RestaurantBean *bean;
    if ([data count] > 0)
    {
        bean = [[RestaurantBean alloc] initWithJson:data];
    }

    return bean;
}


@end
