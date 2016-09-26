//
//  BaseBean.m
//  YokoMobile
//
//  Created by Devangi 20/03/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "BaseBean.h"
#import "YokoAPIUtils.h"

@implementation BaseBean

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 */
- (void) loadBaseJSON:(NSDictionary *)json
{
    _appId = [[YokoAPIUtils stringCheckInDictionary:json key:@"appId"] intValue];
    _author = [YokoAPIUtils stringCheckInDictionary:json key:@"author"];
    _authorId = [YokoAPIUtils stringCheckInDictionary:json key:@"authorId"];
    _coreObjectId = [YokoAPIUtils stringCheckInDictionary:json key:@"id"];
    _createdMainDate = [YokoAPIUtils stringCheckInDictionary:json key:@"createdDate"];
    _detailUrl = [YokoAPIUtils stringCheckInDictionary:json key:@"detailUrl"];
    _imageUrl = [YokoAPIUtils stringCheckInDictionary:json key:@"imageUrl"];
    _isCollected = [[YokoAPIUtils stringCheckInDictionary:json key:@"isCollected"] boolValue];
    _isDone = [[YokoAPIUtils stringCheckInDictionary:json key:@"isDone"] boolValue];
    _isLoved = [[YokoAPIUtils stringCheckInDictionary:json key:@"isLoved"] boolValue];
    _objectId = [YokoAPIUtils stringCheckInDictionary:json key:@"objectId"];
    _objectDescription = [YokoAPIUtils stringCheckInDictionary:json key:@"description"];
    _objectPrivate = [[YokoAPIUtils stringCheckInDictionary:json key:@"private"] boolValue];
    _objectVersion = [[YokoAPIUtils stringCheckInDictionary:json key:@"version"] intValue];
    _title = [YokoAPIUtils stringCheckInDictionary:json key:@"title"];
    _type = [YokoAPIUtils stringCheckInDictionary:json key:@"type"];
    _url = [YokoAPIUtils stringCheckInDictionary:json key:@"url"];
    _status = [YokoAPIUtils stringCheckInDictionary:json key:@"status"];
}


@end
