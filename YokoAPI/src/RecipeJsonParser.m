//
//  RecipeJSONParser.m
//  YokoMobile
//
//  Created by Glam on 17/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "RecipeJsonParser.h"

@implementation RecipeJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns recipe object.
 */
+ (RecipeBean *) parseJSON:(NSDictionary *)data
{
    RecipeBean *bean;
    if ([data count] > 0)
    {
        bean = [[RecipeBean alloc] initWithJson:data];
    }

    return bean;
}


@end
