//
//  AddCollectionJsonParser.m
//  YokoAPI
//
//  Created by Devangi on 08/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "AddCollectionJsonParser.h"
#import "CollectionBean.h"

@implementation AddCollectionJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns array of objects.
 */
+ (NSArray *) parseJSON:(NSDictionary *)data
{
    NSMutableArray *beans = [[NSMutableArray alloc] init];
    if ([data count] > 0)
    {
        CollectionBean *bean = [[CollectionBean alloc] initWithJson:data];
        [beans addObject:bean];
    }

    return beans;
}


@end
