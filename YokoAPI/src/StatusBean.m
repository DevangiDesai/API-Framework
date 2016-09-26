//
//  StatusBean.m
//  YokoMobile
//
//  Created by Devangi 06/02/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "StatusBean.h"
#import "YokoAPIUtils.h"

@implementation StatusBean

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
}


@end
