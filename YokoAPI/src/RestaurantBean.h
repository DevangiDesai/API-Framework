//
//  RestaurantBean.h
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationBean.h"
#import "BaseBean.h"
#import "UserBean.h"
#import "TimeBean.h"
#import "CommentBean.h"
#import "CollectionBean.h"

/**
 * @brief This class contains information that represents restaurant.
 */
@interface RestaurantBean : BaseBean

@property (nonatomic, strong) NSString *canonical;
@property (nonatomic, strong) NSString *ogTitle;
@property (nonatomic, strong) NSString *ogDescription;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *attire;
@property (nonatomic, strong) NSString *cuisine;
@property (nonatomic, assign) NSInteger cost;

@property (nonatomic, assign) BOOL requiresReservations;
@property (nonatomic, assign) BOOL hasBar;
@property (nonatomic, assign) BOOL hasFullBar;
@property (nonatomic, assign) BOOL hasBeerWine;
@property (nonatomic, assign) BOOL hasStreetParking;
@property (nonatomic, assign) BOOL hasParkingLot;
@property (nonatomic, assign) BOOL hasValetParking;
@property (nonatomic, strong) NSString *externalSourceId;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *fullAddress;
@property (nonatomic, strong) NSString *directionsUrl;
@property (nonatomic, strong) NSString *websiteName;
@property (nonatomic, strong) NSString *priceRange;
@property (nonatomic, strong) NSString *goodToKnow;
@property (nonatomic, assign) NSInteger collectCount;
@property (nonatomic, assign) NSInteger loveCount;
@property (nonatomic, assign) NSInteger diditCount;
@property (nonatomic, assign) BOOL showTally;
@property (nonatomic, strong) NSString *editUrl;
@property (nonatomic, strong) NSString *affiliateId;
@property (nonatomic, strong) NSString *slots;
@property (nonatomic, strong) NSString *diditBtnTitleMsgKey;
@property (nonatomic, strong) NSString *commentDialog;
@property (nonatomic, assign) BOOL attachImage;
@property (nonatomic, assign) BOOL editCover;
@property (nonatomic, strong) NSString *lastDiditMessageKey;
@property (nonatomic, strong) NSString *ctaText;
@property (nonatomic, strong) NSString *ctaButton;
@property (nonatomic, assign) BOOL canComment;

@property (nonatomic, strong) NSString *dinningTime;

@property (nonatomic, strong) NSMutableArray *nearby;
@property (nonatomic, strong) NSMutableArray *relatedCollections;
@property (nonatomic, strong) NSMutableArray *userCollections;
@property (nonatomic, strong) NSMutableArray *connections;
@property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, strong) LocationBean *locationBean;
@property (nonatomic, strong) UserBean *userBean;
@property (nonatomic, strong) DateBean *createdDate;
@property (nonatomic, strong) DateBean *updatedDate;
@property (nonatomic, strong) CommentBean *commentBean;
@property (nonatomic, strong) ImageAttributesBean *imageAttributesBean;
@property (nonatomic, strong) TimeBean *lunchHour;
@property (nonatomic, strong) TimeBean *dinnerHour;

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id)initWithJson:(NSDictionary *)json;

@end
