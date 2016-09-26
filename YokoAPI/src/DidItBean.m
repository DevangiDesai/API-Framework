//
//  DidItBean.m
//  YokoMobile
//
//  Created by Glam on 14/01/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "DidItBean.h"
#import "YokoAPIUtils.h"

@implementation DidItBean

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
    self.userBean = [[UserBean alloc] initWithJson:[json objectForKey:@"user"]];
    self.imageAttrs = [YokoAPIUtils stringCheckInDictionary:json key:@"imageAttrs"];
}


@end
