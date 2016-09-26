//
//  DidItBean.h
//  YokoMobile
//
//  Created by Glam on 14/01/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"
#import "UserBean.h"

/**
 * @brief This class contains information that represents didit.
 */
@interface DidItBean : BaseBean

@property (nonatomic, strong) NSString *imageAttrs;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) UserBean *userBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
