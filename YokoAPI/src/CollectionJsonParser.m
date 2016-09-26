//
//  CollectionJsonParser.m
//  YokoAPI
//
//  Created by Devangi 26/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "CollectionJsonParser.h"
#import "CollectionBean.h"

@implementation CollectionJsonParser

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
        if ([[data allKeys] containsObject:@"collections"])
        {
            NSArray *collectionArray = [data objectForKey:@"collections"];
            if ([collectionArray count] > 0)
            {
                for ( int i = 0; i < [collectionArray count]; i++)
                {
                    NSDictionary *dict = [collectionArray objectAtIndex:i];
                    if ([[collectionArray objectAtIndex:i] isKindOfClass:[NSDictionary class]])
                    {
                        CollectionBean *bean = [[CollectionBean alloc] initWithJson:dict];
                        [beans addObject:bean];
                    }
                }
            }
        }
        else
        {
            NSEnumerator *enumerator = [data keyEnumerator];
            id key;
            while ( (key = [enumerator nextObject]) )
            {
                NSDictionary *subDictionary = [data objectForKey:key];
                CollectionBean *bean = [[CollectionBean alloc] initWithJson:subDictionary];
                [beans addObject:bean];
            }
        }
    }

    return beans;
}


@end
