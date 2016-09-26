//
//  Discover.h
//  YokoMobile
//
//  Created by Devangi on 05/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns array of objects.
 */
+ (NSArray *)parseJSON:(NSDictionary *)data;

@end
