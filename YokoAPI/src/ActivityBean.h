//
//  ActivityBean.h
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"
#import "UserBean.h"
#import "CommentBean.h"
#import "RestaurantBean.h"
#import "RecipeBean.h"
#import "ImageAttributesBean.h"
#import "DateBean.h"
#import "LocationBean.h"

/**
 * @brief This class contains information that represents activty.
 */
@interface ActivityBean : BaseBean

@property (nonatomic, strong) NSString *annotation;
@property (nonatomic, assign) double imageAspectRatio;
@property (nonatomic, assign) BOOL showToolbar;
@property (nonatomic, assign) NSInteger collectCount;
@property (nonatomic, assign) NSInteger loveCount;
@property (nonatomic, assign) NSInteger diditCount;
@property (nonatomic, assign) BOOL showCount;
@property (nonatomic, strong) NSString *diditBtnTitleMsgKey;
@property (nonatomic, assign) BOOL showActivity;
@property (nonatomic, strong) NSString *activityMessageKey;
@property (nonatomic, strong) NSString *collectionName;
@property (nonatomic, strong) NSString *collectionLink;
@property (nonatomic, assign) BOOL showComments;
@property (nonatomic, strong) NSString *collectionMemberId;
@property (nonatomic, strong) NSString *collectionId;
@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) NSMutableArray *commentBeans;

//
@property (nonatomic, strong) NSDate *eventDate;
// Content Object
@property (nonatomic, strong) RecipeBean *recipeBean;
@property (nonatomic, strong) RestaurantBean *resurantBean;

@property (nonatomic, strong) DateBean *createdDate;
@property (nonatomic, strong) DateBean *updatedDate;
@property (nonatomic, strong) ImageAttributesBean *imageAttributesBean;
@property (nonatomic, strong) UserBean *userBean;
@property (nonatomic, strong) CommentBean *commentBean;
@property (nonatomic, strong) LocationBean *locationBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
