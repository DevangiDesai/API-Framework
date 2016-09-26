//
//  ProfileJSONParser.m
//  YokoMobile
//
//  Created by Devangi on 30/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "ProfileJsonParser.h"

@implementation ProfileJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns user object.
 */
+ (UserBean *) parseJSON:(NSDictionary *)data
{
    UserBean *bean;
    NSDictionary *dict = [data objectForKey:@"profile"];
    if ([dict count] > 0)
    {
        bean = [[UserBean alloc] initWithJson:dict];
    }

    return bean;
}


@end
