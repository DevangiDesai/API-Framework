//
//  CommentListJSONParser.h
//  YokoMobile
//
//  Created by Devangi Desai on 22/01/14.
//  Copyright (c) 2013 Glam Media. All rights reserved.
//

@interface CommentListJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 * @return returns array of objects.
 */
+ (NSArray *)parseJSON:(NSDictionary *)data;

@end
