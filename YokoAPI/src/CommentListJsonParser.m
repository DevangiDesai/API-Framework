//
//  CommentListJSONParser.m
//  YokoMobile
//
//  Created by Devangi Desai on 22/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "CommentListJsonParser.h"
#import "CommentBean.h"

@implementation CommentListJsonParser

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns array of objects.
 */
+ (NSArray *) parseJSON:(NSDictionary *)data
{
    NSMutableArray *beans = [[NSMutableArray alloc] init];
    NSArray *commentsArray = [data objectForKey:@"comments"];

    CommentBean *bean;
    if ([commentsArray count] > 0)
    {
        for ( int i = 0; i < [commentsArray count]; i++)
        {
            NSDictionary *dict = [commentsArray objectAtIndex:i];
            if ([[commentsArray objectAtIndex:i] isKindOfClass:[NSDictionary class]])
            {
                bean = [[CommentBean alloc] initWithJson:dict];
                [beans addObject:bean];
            }
        }
    }

    NSDictionary *commentDict = [data objectForKey:@"comment"];
    if ([commentDict count] > 0)
    {
        bean = [[CommentBean alloc] initWithJson:commentDict];
        [beans addObject:bean];
    }

    return beans;
}


@end
