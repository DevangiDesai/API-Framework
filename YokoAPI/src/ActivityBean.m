//
//  ActivityBean.m
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "ActivityBean.h"
#import "YokoAPIUtils.h"

@implementation ActivityBean

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
    self.activityMessageKey = [YokoAPIUtils stringCheckInDictionary:json key:@"activityMessageKey"];
    self.annotation = [YokoAPIUtils stringCheckInDictionary:json key:@"annotation"];
    self.collectCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"collectCount"] intValue];
    self.collectionId = [YokoAPIUtils stringCheckInDictionary:json key:@"collectionId"];
    self.collectionLink = [YokoAPIUtils stringCheckInDictionary:json key:@"collectionLink"];
    self.collectionMemberId = [YokoAPIUtils stringCheckInDictionary:json key:@"collectionMemberId"];
    self.collectionName = [YokoAPIUtils stringCheckInDictionary:json key:@"collectionName"];
    self.commentCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"commentCount"] intValue];
    self.diditBtnTitleMsgKey = [YokoAPIUtils stringCheckInDictionary:json key:@"diditBtnTitleMsgKey"];
    self.diditCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"diditCount"] intValue];
    self.imageAspectRatio = [[YokoAPIUtils stringCheckInDictionary:json key:@"imageAspectRatio"] doubleValue];
    self.loveCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"loveCount"] intValue];
    self.showActivity = [[YokoAPIUtils stringCheckInDictionary:json key:@"showActivity"] boolValue];
    self.showComments = [[YokoAPIUtils stringCheckInDictionary:json key:@"showComments"] boolValue];
    self.showCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"showCount"] boolValue];
    self.showToolbar = [[YokoAPIUtils stringCheckInDictionary:json key:@"showToolbar"] boolValue];
    //TODO, needs to refactor
    //capture the eventDate for sort
    // Convert string to date object
    NSString *dateString = [YokoAPIUtils stringCheckInDictionary:json key:@"eventDate"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    self.eventDate = [dateFormat dateFromString:dateString];

    NSDictionary *contentObject = [json objectForKey:@"contentObject"];

    self.imageAttributesBean = [[ImageAttributesBean alloc] initWithJson:[contentObject objectForKey:@"imageAttrs"]];

    NSDictionary *location = [NSDictionary dictionaryWithObjectsAndKeys:[contentObject objectForKey:@"latitude"],@"lat",[contentObject objectForKey:@"longitude"],@"lng", nil];

    self.locationBean = [[LocationBean alloc] initWithJson:location];

    self.userBean = [[UserBean alloc] initWithJson:[json objectForKey:@"user"]];

    self.commentBeans = [NSMutableArray array];

    NSArray *commentArray = [json objectForKey:@"comments"];
    if (commentArray && [commentArray count] > 0)
    {
        for ( NSDictionary *commentDict in commentArray)
        {
            CommentBean *commentBean = [[CommentBean alloc] initWithJson:commentDict];
            [_commentBeans addObject:commentBean];
        }
    }

    //To-Do, change temporaily so that collection will return result, will need refactor in later feature branch
    NSDictionary *collection = [json objectForKey:@"collection"];
    if (collection)
    {
        self.collectionId = [YokoAPIUtils stringCheckInDictionary:collection key:@"id"];

        // API is inconsistent.  JSON key is "title" in discover view and "name" in recipe/restaurant activity feeds
        if ([collection objectForKey:@"title"])
        {
            self.collectionName = [YokoAPIUtils stringCheckInDictionary:collection key:@"title"];
        }
        else
        {
            self.collectionName = [YokoAPIUtils stringCheckInDictionary:collection key:@"name"];
        }

        self.collectionLink = [YokoAPIUtils stringCheckInDictionary:collection key:@"link"];
    }

    NSDictionary *coreObject = [json objectForKey:@"coreObject"];
    if (coreObject)
    {
        self.type = [YokoAPIUtils stringCheckInDictionary:coreObject key:@"type"];
    }
}


@end
