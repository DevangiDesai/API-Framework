//
//  ImageAttributesBean.h
//  YokoMobile
//
//  Created by Devangi Desai on 05/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

/**
 * @brief This class contains information that represents image attributes.
 */
@interface ImageAttributesBean : BaseBean

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, strong) NSString *type;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
