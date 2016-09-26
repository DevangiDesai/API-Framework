//
//  StatusJSONParser.h
//  YokoMobile
//
//  Created by Devangi 06/02/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

@interface StatusJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns object.
 */
+ (NSObject *)parseJSON:(NSDictionary *)data;

@end
