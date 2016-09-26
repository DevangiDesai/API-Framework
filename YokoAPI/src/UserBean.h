//
//  UserBean.h
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"
#import "DateBean.h"
#import "ImageAttributesBean.h"

/**
 * @brief This class contains information that represents user.
 */
@interface UserBean : BaseBean

@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *siteUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *blogName;
@property (nonatomic, strong) NSString *blogUrl;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, assign) NSInteger followerCount;
@property (nonatomic, assign) NSInteger followeeCount;
@property (nonatomic, assign) BOOL editable;
@property (nonatomic, assign) BOOL following;

@property (nonatomic, strong) DateBean *dateBean;
@property (nonatomic, strong) ImageAttributesBean *imageAttributesBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
