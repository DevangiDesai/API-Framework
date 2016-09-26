//
//  BaseBean.h
//  YokoMobile
//
//  Created by Devangi 20/03/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief This class contains information that represents base of model, mostly for common entities.
 */
@interface BaseBean : NSObject

@property (nonatomic, assign) NSInteger appId;
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) BOOL isLoved;
@property (nonatomic, assign) BOOL isCollected;
@property (nonatomic, assign) BOOL isDone;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *coreObjectId;
@property (nonatomic, strong) NSString *objectDescription;
@property (nonatomic, assign) BOOL objectPrivate;
@property (nonatomic, assign) NSInteger objectVersion;
@property (nonatomic, strong) NSString *createdMainDate;
@property (nonatomic, strong) NSString *status;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 */
- (void)loadBaseJSON:(NSDictionary *)json;

@end
