//
//  ActivityEventParser.h
//  YokoAPI
//
//  Created by Devangi 26/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityEventParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @param type response type (profile, restaurant, recipe).
 * @param action - love, collect, didit.
 * @return returns array of objects.
 */
+ (NSArray *)parseJSON:(NSDictionary *)data type:(NSString *)type action:(NSString *)action;

@end
