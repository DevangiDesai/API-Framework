//
//  MapBean.h
//  YokoMobile
//
//  Created by Devangi on 12/12/12.
//  Copyright (c) 2012 Glam Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

/**
 * @brief This class merge location information into one object.
 */
@interface LocationBean : NSObject

@property (nonatomic,strong) NSString *restaurantLatitude;
@property (nonatomic,strong) NSString *restaurantLongitude;
@property (nonatomic,strong) NSString *resturantAddress;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
