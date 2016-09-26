//
//  NotificationDetailParser.h
//  YokoMobile
//
//  Created by Devangi on 24/05/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDetailJsonParser : NSObject

/**
 * @brief  This method is used to parse Data.
 *
 * @param data is used to dictionary object of response.
 */
+ (NSMutableArray *) parseJSON:(NSDictionary *)response;
+ (NSMutableArray *) parseJSONForCannes:(NSDictionary *)response;
@end
