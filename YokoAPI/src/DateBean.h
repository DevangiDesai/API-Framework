//
//  DateBean.h
//  YokoMobile
//
//  Created by Devangi Desai on 05/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

/**
 * @brief This class contains information that represents date.
 */
@interface DateBean : BaseBean

@property (nonatomic, strong) NSData *date;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSString *timezoneType;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
