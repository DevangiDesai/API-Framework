//
//  ImageAttributesBean.m
//  YokoMobile
//
//  Created by Devangi Desai on 05/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "ImageAttributesBean.h"
#import "YokoAPIUtils.h"

@implementation ImageAttributesBean

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
    self.height = [[YokoAPIUtils stringCheckInDictionary:json key:@"height"] intValue];
    self.width = [[YokoAPIUtils stringCheckInDictionary:json key:@"width"] intValue];
}


@end
