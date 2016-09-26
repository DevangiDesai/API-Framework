//
//  NotificationDetailBean.h
//  YokoMobile
//
//  Created by Devangi on 03/05/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseBean.h"
#import "UserBean.h"

/**
 * @brief This class contains information that represents notification.
 */
@interface NotificationBean : BaseBean

@property (nonatomic,strong) UserBean *userBean;
@property (nonatomic,strong) NSMutableArray *notiicationArr;
@property (nonatomic, strong) NSString *notificationType;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *objectType;
@property (nonatomic, strong) NSString *recipientId;
@property (nonatomic, strong) NSString *read;
@property (nonatomic,strong) NSString *messageHtml;
@property (nonatomic,strong) NSString *userBio;
@property (nonatomic,strong) NSString *userBlogName;
@property (nonatomic,strong) NSString *userBlogUrl;
@property (nonatomic,strong) NSString *userSiteUrl;
@property (nonatomic,strong) NSString *userSlug;
@property (nonatomic,strong) NSString *userTagline;
@property (nonatomic,strong) NSString *coreObjectId;
@property (nonatomic,strong) NSString *coreObjectType;
@property (nonatomic,strong) NSString *collectionName;
@property (nonatomic,strong) NSString *time;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
