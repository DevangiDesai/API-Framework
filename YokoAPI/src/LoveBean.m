//
//  LoveBean.m
//  YokoMobile
//
//  Created by Glam on 14/12/12.
//  Copyright (c) 2012 Glam Media. All rights reserved.
//

#import "LoveBean.h"
#import "YokoAPIUtils.h"

@implementation LoveBean

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
    self.isLoved = [[YokoAPIUtils stringCheckInDictionary:json key:@"isLoved"] boolValue];
}


@end
