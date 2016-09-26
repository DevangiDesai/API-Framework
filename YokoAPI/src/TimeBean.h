//
//  TimeBean.h
//  YokoMobile
//
//  Created by Glam on 11/01/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

/**
 * @brief This class merge time information into one object.
 */
@interface TimeBean : NSObject

@property (nonatomic, strong) NSString *ampm;
@property (nonatomic, strong) NSString *hr12;
@property (nonatomic, strong) NSString *hr24;
@property (nonatomic, strong) NSString *min;
@property (nonatomic, strong) TimeBean *openTime;
@property (nonatomic, strong) TimeBean *closeTime;

/**
 *  @brief  This method take open and close time for Lunch/Dinner
 *
 *  @param  openTime : map contain open time of lunch/dinner
 *  @param  closeTime: map contain close time of lunch/dinner
 *  @return id returns either array or object
 */
- (id)initWithOpenTime:(NSDictionary *)openTime andCloseTime:(NSDictionary *)closeTime;

@end
