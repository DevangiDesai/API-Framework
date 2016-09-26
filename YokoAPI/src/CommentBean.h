//
//  CommentBean.h
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBean.h"
#import "BaseBean.h"

/**
 * @brief This class contains information that represents comment.
 */
@interface CommentBean : BaseBean

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UserBean *userBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
