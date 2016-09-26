//
//  Discover.m
//  YokoMobile
//
//  Created by Devangi on 05/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "FollowingFollowerJsonParser.h"
#import "UserBean.h"

@implementation FollowingFollowerJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns array of objects.
 */
+ (NSArray *) parseJSON:(NSDictionary *)data
{
    NSDictionary *dict = [data objectForKey:@"users"];
    NSMutableArray *beans = [[NSMutableArray alloc] init];
    if ([dict count] > 0)
    {
        NSEnumerator *enumerator = [dict keyEnumerator];
        id key;
        while ( (key = [enumerator nextObject]) )
        {
            NSDictionary *subDictionary = [dict objectForKey:key];
            UserBean *bean = [[UserBean alloc] initWithJson:subDictionary];
            [beans addObject:bean];
        }
    }

    return beans;
}


@end
