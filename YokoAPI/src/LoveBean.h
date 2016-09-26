//
//  LoveBean.h
//  YokoMobile
//
//  Created by Glam on 14/12/12.
//  Copyright (c) 2012 Glam Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

/**
 * @brief This class contains information that represents love object.
 */
@interface LoveBean : BaseBean

@property (nonatomic,strong) NSString *status;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
