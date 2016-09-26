//
//  ProfileJSONParser.h
//  YokoMobile
//
//  Created by Devangi on 30/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBean.h"

@interface ProfileJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns user object.
 */
+ (UserBean *)parseJSON:(NSDictionary *)data;

@end
