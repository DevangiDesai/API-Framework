//
//  ImageUploadParser.m
//  YokoMobile
//
//  Created by Devangi Desai on 17/12/12.
//  Copyright (c) 2012 Glam Media. All rights reserved.
//

#import "ImageUploadJsonParser.h"

@implementation ImageUploadJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 */
+ (ImageAttributesBean *) parseJSON:(NSDictionary *)data
{
    ImageAttributesBean *bean;
    if ([data count] > 0)
    {
        bean = [[ImageAttributesBean alloc] initWithJson:data];
    }

    return bean;
}


@end
