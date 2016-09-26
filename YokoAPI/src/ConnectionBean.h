//
//  ConnectionBean.h
//  YokoMobile
//
//  Created by Glam on 17/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"
#import "UserBean.h"
#import "RecipeBean.h"

/**
 * @brief This class contains information that represents connection.
 */
@interface ConnectionBean : BaseBean

@property (nonatomic, strong) UserBean *userBean;
@property (nonatomic, strong) RecipeBean *recipeBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
