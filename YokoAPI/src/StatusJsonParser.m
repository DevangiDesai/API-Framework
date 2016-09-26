//
//  StatusJSONParser.m
//  YokoMobile
//
//  Created by Devangi 06/02/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "StatusJsonParser.h"
#import "BaseBean.h"

@implementation StatusJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns object.
 */
+ (NSObject *) parseJSON:(NSDictionary *)data
{
    BaseBean *bean;
    if ([data count] > 0)
    {
        bean = [[BaseBean alloc] init];
        [bean loadBaseJSON:data];
    }

    return bean;
}


@end
