//
//  UserBean.m
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "UserBean.h"
#import "YokoAPIUtils.h"

@implementation UserBean

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
    self.avatarUrl = [YokoAPIUtils stringCheckInDictionary:json key:@"avatarUrl"];
    self.bio = [YokoAPIUtils stringCheckInDictionary:json key:@"bio"];
    self.blogName = [YokoAPIUtils stringCheckInDictionary:json key:@"blogName"];
    self.blogUrl = [YokoAPIUtils stringCheckInDictionary:json key:@"blogUrl"];
    self.screenName = [YokoAPIUtils stringCheckInDictionary:json key:@"screenName"];
    self.siteUrl = [YokoAPIUtils stringCheckInDictionary:json key:@"siteUrl"];
    self.slug = [YokoAPIUtils stringCheckInDictionary:json key:@"slug"];
    self.tagline = [YokoAPIUtils stringCheckInDictionary:json key:@"tagline"];
    self.fullName = [YokoAPIUtils stringCheckInDictionary:json key:@"fullName"];
    self.followerCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"followerCount"] intValue];
    self.followeeCount = [[YokoAPIUtils stringCheckInDictionary:json key:@"followeeCount"] intValue];
    self.editable = [[YokoAPIUtils stringCheckInDictionary:json key:@"editable"] boolValue];
    self.following = [[YokoAPIUtils stringCheckInDictionary:json key:@"following"] boolValue];

    self.imageAttributesBean = [[ImageAttributesBean alloc] initWithJson:[json objectForKey:@"imageAttrs"]];
}


@end
