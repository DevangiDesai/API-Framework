//
//  RecipeJSONParser.h
//  YokoMobile
//
//  Created by Glam on 17/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "RecipeBean.h"

@interface RecipeJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns recipe object.
 */
+ (RecipeBean *)parseJSON:(NSDictionary *)data;

@end
