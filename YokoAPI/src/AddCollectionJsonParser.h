//
//  AddCollectionJsonParser.h
//  YokoAPI
//
//  Created by Devangi on 08/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCollectionJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns array of objects.
 */
+ (NSArray *)parseJSON:(NSDictionary *)data;

@end
