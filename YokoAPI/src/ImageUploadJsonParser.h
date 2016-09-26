//
//  ImageUploadParser.h
//  YokoMobile
//
//  Created by Devangi Desai on 17/12/12.
//  Copyright (c) 2012 Glam Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageAttributesBean.h"

@interface ImageUploadJsonParser : NSObject

/**
 * @brief This is used for parsing JSON data.
 *
 * @param data to parse.
 */
+ (ImageAttributesBean *)parseJSON:(NSDictionary *)data;

@end
