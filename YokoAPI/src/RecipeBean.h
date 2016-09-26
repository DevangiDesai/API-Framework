//
//  RecipeBean.h
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBean.h"
#import "DateBean.h"
#import "UserBean.h"
#import "ImageAttributesBean.h"
#import "CollectionBean.h"
#import "CommentBean.h"

/**
 * @brief This class contains information that represents recipe.
 */
@interface RecipeBean : BaseBean

@property (nonatomic, strong) NSString *cuisine;
@property (nonatomic, strong) NSString *complexity;
@property (nonatomic, strong) NSString *methods;
@property (nonatomic, strong) NSString *allergies;
@property (nonatomic, strong) NSString *dietaryConsiderations;
@property (nonatomic, strong) NSString *healthFactor;
@property (nonatomic, strong) NSString *yields;
@property (nonatomic, strong) NSString *prepTime;
@property (nonatomic, strong) NSString *cookTime;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *externalUrl;
@property (nonatomic, strong) NSString *canonical;
@property (nonatomic, strong) NSString *ogTitle;
@property (nonatomic, strong) NSString *ogDescription;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, assign) NSInteger collectCount;
@property (nonatomic, assign) NSInteger loveCount;
@property (nonatomic, assign) NSInteger diditCount;
@property (nonatomic, assign) BOOL showTally;
@property (nonatomic, strong) NSString *editUrl;
@property (nonatomic, strong) NSString *affiliateId;
@property (nonatomic, strong) NSString *slots;
@property (nonatomic, strong) NSString *diditBtnTitleMsgKey;
@property (nonatomic, strong) NSString *commentDialog;
@property (nonatomic, strong) NSString *descriptionKey;
@property (nonatomic, strong) NSString *lastDiditMessageKey;
@property (nonatomic, strong) NSString *ctaText;
@property (nonatomic, strong) NSString *ctaButton;
@property (nonatomic, assign) BOOL canComment;

@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, strong) NSArray *steps;

@property (nonatomic, strong) UserBean *userBean;
@property (nonatomic, strong) DateBean *createdDate;
@property (nonatomic, strong) DateBean *updatedDate;
@property (nonatomic, strong) CommentBean *commentBean;
@property (nonatomic, strong) ImageAttributesBean *imageAttributesBean;

@property (nonatomic, strong) NSMutableArray *relatedCollections;
@property (nonatomic, strong) NSMutableArray *userCollections;
@property (nonatomic, strong) NSMutableArray *connections;
@property (nonatomic, strong) NSMutableArray *comments;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
