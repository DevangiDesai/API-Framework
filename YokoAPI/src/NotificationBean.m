//
//  NotificationDetailBean.m
//  YokoMobile
//
//  Created by Devangi on 03/05/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import "NotificationBean.h"
#import "YokoAPIUtils.h"
#import "UserBean.h"

@implementation NotificationBean

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
- (void) loadJSON:(NSDictionary *)notifiationDict
{
    [self loadBaseJSON:notifiationDict];
    self.notificationType = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"notificationType"];
    self.objectId = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"obectId"];
    self.coreObjectId = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"coreObjectId"];
    self.coreObjectType = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"coreObjectType"];
    self.collectionName = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"collectionName"];
    self.time = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"time"];
    self.objectType = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"objctType"];
    self.recipientId = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"recpientId"];
    self.read = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"read"];
    self.url = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"url"];
    NSDictionary *userDict = [notifiationDict objectForKey:@"user"];
    self.userBean = [[UserBean alloc] initWithJson:userDict];
    self.userBio = [YokoAPIUtils stringCheckInDictionary:userDict key:@"bio"];
    self.userBlogName = [YokoAPIUtils stringCheckInDictionary:userDict key:@"blogName"];
    self.userBlogUrl = [YokoAPIUtils stringCheckInDictionary:userDict key:@"blogUrl"];
    self.userSiteUrl = [YokoAPIUtils stringCheckInDictionary:userDict key:@"siteUrl"];
    self.userTagline = [YokoAPIUtils stringCheckInDictionary:userDict key:@"tagline"];
    self.messageHtml = [YokoAPIUtils stringCheckInDictionary:notifiationDict key:@"messageHtml"];  //[self getTextFromNotificationType];
}


- (NSString *) getTextFromNotificationType
{
    NSString *textstr = nil;
    NotificationBean *bean = self;
    if ([bean.notificationType isEqualToString:@"didit"])
    {
        if ([bean.coreObjectType isEqualToString:@"Recipe"])
        {
            textstr = [[bean.userBean.title stringByAppendingString:@" made your "] stringByAppendingString:bean.title];
        }
    }
    else if ([bean.notificationType isEqualToString:@"collect"])
    {
        if ([bean.coreObjectType isEqualToString:@"Recipe"])
        {
            textstr = [[[[bean.userBean.title stringByAppendingString:@" added "] stringByAppendingString:bean.title ] stringByAppendingString:@" to the collection "] stringByAppendingString:bean.collectionName];
        }
        else if ([bean.coreObjectType isEqualToString:@"Restaurant"])
        {
        }
    }
    else if ([bean.notificationType isEqualToString:@"love"])
    {
        textstr = [[bean.userBean.title stringByAppendingString:@" loves "] stringByAppendingString:bean.title];
    }
    else if ([bean.notificationType isEqualToString:@"comment"])
    {
        textstr = [[bean.userBean.title stringByAppendingString:@" commented on your note about "] stringByAppendingString:bean.title];
    }
    else if ([bean.notificationType isEqualToString:@"follow"])
    {
        textstr = [bean.userBean.title stringByAppendingString:@" is now following you."];
    }

    return textstr;
}


@end
