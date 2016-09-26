//
//  MemberBean.h
//  YokoMobile
//
//  Created by Devangi 18/03/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

/**
 * @brief This class contains information that represents member of collection.
 */
@interface MemberBean : BaseBean

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
