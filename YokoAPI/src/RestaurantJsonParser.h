//
//  RecipeJSONParser.h
//  YokoMobile
//
//  Created by Glam on 17/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "RestaurantBean.h"

@interface RestaurantJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns restaurant object.
 */
+ (RestaurantBean *)parseJSON:(NSDictionary *)data;

@end
