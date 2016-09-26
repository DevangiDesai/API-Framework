//
//  ActivityEventBean.m
//  YokoAPI
//
//  Created by Devangi 26/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "ActivityEventBean.h"
#import "YokoAPIUtils.h"

@implementation ActivityEventBean

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
    NSDictionary *coreObjectJSON = [json objectForKey:@"coreObject"];
    [super loadBaseJSON:coreObjectJSON];
    self.activityId = [YokoAPIUtils stringCheckInDictionary:json key:@"activityId"];
    self.eventType = [YokoAPIUtils stringCheckInDictionary:json key:@"eventType"];
    self.activity = [YokoAPIUtils stringCheckInDictionary:json key:@"activity"];
    self.timelineDate = [YokoAPIUtils stringCheckInDictionary:json key:@"timelineDate"];
    self.relativeTime = [YokoAPIUtils stringCheckInDictionary:json key:@"relativeTime"];
    self.annotation = [YokoAPIUtils stringCheckInDictionary:json key:@"annotation"];
    self.olderTime = [YokoAPIUtils stringCheckInDictionary:json key:@"olderTime"];
    self.olderId = [YokoAPIUtils stringCheckInDictionary:json key:@"olderId"];
    self.userImageUrl = [YokoAPIUtils stringCheckInDictionary:json key:@"imageUrl"];
    self.userImageAttributesBean = [[ImageAttributesBean alloc] initWithJson:[json objectForKey:@"imageAttrs"]];

    self.userBean = [[UserBean alloc] initWithJson:[json objectForKey:@"user"]];
    self.collectionBean = [[CollectionBean alloc] initWithJson:[json objectForKey:@"collection"]];
    self.imageAttributesBean = [[ImageAttributesBean alloc] initWithJson:[coreObjectJSON objectForKey:@"imageAttrs"]];
}


@end
