//
//  RestaurantBeanMap.h
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

@class LocationBean;

/**
 * @brief This class contains information that represents map object of restaurant.
 */
@interface RestaurantBeanMap : BaseBean

@property (nonatomic,strong) NSString *restaurantName;
@property (nonatomic,strong) LocationBean *locationBean;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
