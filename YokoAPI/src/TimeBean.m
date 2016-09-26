//
//  TimeBean.m
//  YokoMobile
//
//  Created by Glam on 11/01/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "TimeBean.h"
#import "YokoAPIUtils.h"

@implementation TimeBean
@synthesize ampm = _ampm;
@synthesize hr12 = _hr12;
@synthesize hr24 = _hr24;
@synthesize min = _min;
@synthesize closeTime = _closeTime;
@synthesize openTime = _openTime;

/**
 * @brief  This method take open and close time for Lunch/Dinner
 *
 * @param  openTime : map contain open time of lunch/dinner
 * @param  closeTime: map contain close time of lunch/dinner
 * @return id returns either array or object
 */
- (id) initWithOpenTime:(NSDictionary *)openTime andCloseTime:(NSDictionary *)closeTime
{
    self = [self init];
    if (self != nil)
    {
        _openTime = [self setTime:openTime];
        _closeTime = [self setTime:closeTime];
    }

    return self;
}


/**
 *  @brief  This method take open and close time for Lunch/Dinner
 *
 *  @param  timeData dictionary of time data
 *  @return returns timebean
 */
- (TimeBean *) setTime:(NSDictionary *)timeData
{
    TimeBean *temp = [[TimeBean alloc] init];
    temp.ampm = [YokoAPIUtils stringCheckInDictionary:timeData key:@"ampm"];
    temp.hr12 = [YokoAPIUtils stringCheckInDictionary:timeData key:@"hr12"];
    temp.hr24 = [YokoAPIUtils stringCheckInDictionary:timeData key:@"hr24"];
    temp.min = [YokoAPIUtils stringCheckInDictionary:timeData key:@"min"];
    return temp;
}


@end
