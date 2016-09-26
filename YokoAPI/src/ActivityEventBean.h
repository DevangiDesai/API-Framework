//
//  ActivityEventBean.h
//  YokoAPI
//
//  Created by Devangi 26/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "BaseBean.h"
#import "UserBean.h"
#import "CollectionBean.h"
#import "ImageAttributesBean.h"

/**
 * @brief This class contains information that represents activty event (love, didit, collect).
 */
@interface ActivityEventBean : BaseBean

@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *eventType;
@property (nonatomic, strong) NSString *activity;
@property (nonatomic, strong) NSString *timelineDate;
@property (nonatomic, strong) NSString *relativeTime;
@property (nonatomic, strong) NSString *annotation;
@property (nonatomic, assign) double imageAspectRatio;
@property (nonatomic, strong) NSString *olderTime;
@property (nonatomic, strong) NSString *olderId;
@property (nonatomic, strong) NSString *userImageUrl;

@property (nonatomic, strong) UserBean *userBean;
@property (nonatomic, strong) CollectionBean *collectionBean;
@property (nonatomic, strong) ImageAttributesBean *userImageAttributesBean;
@property (nonatomic, strong) ImageAttributesBean *imageAttributesBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id) initWithJson:(NSDictionary *)json;

@end
