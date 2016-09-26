//
//  Collection.h
//  YokoMobile
//
//  Created by Devangi Desai on 05/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"

/**
 * @brief This class contains information that represents collect.
 */
@interface CollectionBean : BaseBean

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *contentId;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, assign) NSInteger subscriptionCount;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id) initWithJson:(NSDictionary *)json;

@end
