//
//  Collection.m
//  YokoMobile
//
//  Created by Devangi Desai on 05/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "CollectionBean.h"
#import "MemberBean.h"
#import "YokoAPIUtils.h"

@implementation CollectionBean

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id) initWithJson:(NSDictionary *)json
{
    self = [super init];

    if (self != nil)
    {
        [self loadJSON:json];
    }

    return self;
}


/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 */
- (void) loadJSON:(NSDictionary *)json
{
    [super loadBaseJSON:json];
    self.size = [[YokoAPIUtils stringCheckInDictionary:json key:@"size"] intValue];
    self.slug = [YokoAPIUtils stringCheckInDictionary:json key:@"slug"];
    self.contentId = [YokoAPIUtils stringCheckInDictionary:json key:@"contentId"];
    self.message = [YokoAPIUtils stringCheckInDictionary:json key:@"msg"];
    self.members = [NSMutableArray array];
    self.subscriptionCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"subscriptionCount"] intValue];

    NSArray *memberArray = [json objectForKey:@"members"];
    if (memberArray && [memberArray count] > 0)
    {
        for (NSDictionary *memberDict in memberArray)
        {
            if ([YokoAPIUtils checkNullDictionary:memberDict])
            {
                MemberBean *memberBean = [[MemberBean alloc] initWithJson:memberDict];
                [_members addObject:memberBean];
            }
        }
    }
}


@end
