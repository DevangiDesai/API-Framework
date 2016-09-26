//
//  RestaurantBean.m
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "RestaurantBean.h"
#import "YokoAPIUtils.h"
#import "UserBean.h"
#import "TimeBean.h"
#import "RecipeBean.h"

@implementation RestaurantBean

/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 *  @return id returns either array or object
 */
- (id) initWithJson:(NSDictionary *)json
{
    self = [super init];

    if (self != nil)
    {
        [self loadJSON:json];
    }

    return self;
}


/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param json dictionary of response
 */
- (void) loadJSON:(NSDictionary *)json
{
    NSDictionary *restaurantJson;
    NSDictionary *restaurant = [json objectForKey:@"restaurant"];
    if (restaurant)
    {
        restaurantJson = restaurant;
    }
    else
    {
        restaurantJson = json;
    }

    [super loadBaseJSON:json];
    NSDictionary *head = [json objectForKey:@"head"];
    self.canonical = [YokoAPIUtils stringCheckInDictionary:head key:@"canonical"];
    self.ogTitle = [YokoAPIUtils stringCheckInDictionary:[head objectForKey:@"content"] key:@"ogTitle"];
    self.ogDescription = [YokoAPIUtils stringCheckInDictionary:[head objectForKey:@"content"] key:@"ogDescription"];

    self.address = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"address"];
    self.city = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"city"];
    self.state = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"state"];
    self.zip = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"zip"];
    self.country = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"country"];
    self.phone = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"phone"];
    self.website = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"website"];
    self.attire = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"attire"];
    self.cuisine = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"cuisine"];
    self.cost = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"cost"] intValue];
    self.requiresReservations = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"requiresReservations"] boolValue];
    self.hasBar = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"hasBar"] boolValue];
    self.hasBeerWine = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"hasBeerWine"] boolValue];
    self.hasFullBar = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"hasFullBar"] boolValue];
    self.hasParkingLot = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"hasParkingLot"] boolValue];
    self.hasStreetParking = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"hasStreetParking"] boolValue];
    self.hasValetParking = [[YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"hasValetParking"] boolValue];
    self.externalSourceId = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"externalSourceId"];
    self.slug = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"slug"];
    self.websiteName = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"websiteName"];
    self.directionsUrl = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"directionsUrl"];
    self.fullAddress = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"fullAddress"];
    self.priceRange = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"priceRange"];
    self.goodToKnow = [YokoAPIUtils stringCheckInDictionary:restaurantJson key:@"goodToKnow"];

    NSDictionary *location = [NSDictionary dictionaryWithObjectsAndKeys:[restaurantJson objectForKey:@"latitude"],@"lat",[restaurant objectForKey:@"longitude"],@"lng",_address,@"address", nil];
    self.locationBean = [[LocationBean alloc] initWithJson:location];

    NSDictionary *tally = [json objectForKey:@"tally"];
    self.isCollected = [[YokoAPIUtils stringCheckInDictionary:tally key:@"isCollected"] boolValue];
    self.isLoved = [[YokoAPIUtils stringCheckInDictionary:tally key:@"isLoved"] boolValue];
    self.isDone = [[YokoAPIUtils stringCheckInDictionary:tally key:@"isDone"] boolValue];
    self.collectCount = [[YokoAPIUtils stringCheckInDictionary:tally key:@"collectCount"] intValue];
    self.loveCount = [[YokoAPIUtils stringCheckInDictionary:tally key:@"loveCount"] intValue];
    self.diditCount = [[YokoAPIUtils stringCheckInDictionary:tally key:@"diditCount"] intValue];

    self.showTally = [[YokoAPIUtils stringCheckInDictionary:json key:@"showTally"] boolValue];
    self.editUrl = [YokoAPIUtils stringCheckInDictionary:json key:@"editUrl"];

    NSDictionary *related = [json objectForKey:@"related"];
    self.affiliateId = [YokoAPIUtils stringCheckInDictionary:related key:@"affiliateId"];
    self.slots = [YokoAPIUtils stringCheckInDictionary:related key:@"slots"];

    self.diditBtnTitleMsgKey = [YokoAPIUtils stringCheckInDictionary:json key:@"diditBtnTitleMsgKey"];
    self.commentDialog = [YokoAPIUtils stringCheckInDictionary:json key:@"commentDialog"];
    self.lastDiditMessageKey = [YokoAPIUtils stringCheckInDictionary:json key:@"lastDiditMessageKey"];

    self.ctaText = [YokoAPIUtils stringCheckInDictionary:[json objectForKey:@"ctaMessageKeys"] key:@"ctaText"];
    self.ctaButton = [YokoAPIUtils stringCheckInDictionary:[json objectForKey:@"ctaMessageKeys"] key:@"ctaButton"];

    self.canComment = [[YokoAPIUtils stringCheckInDictionary:json key:@"canComment"] boolValue];

    self.imageAttributesBean = [[ImageAttributesBean alloc] initWithJson:[restaurant objectForKey:@"imageAttrs"]];

    self.userBean = [[UserBean alloc] initWithJson:[json objectForKey:@"profile"]];
    self.createdDate = [[DateBean alloc] initWithJson:[restaurantJson objectForKey:@"createdDate"]];
    self.updatedDate = [[DateBean alloc] initWithJson:[restaurantJson objectForKey:@"updatedDate"]];

    NSArray *resultCollections = [[related objectForKey:@"collections"] objectForKey:@"collections"];
    self.relatedCollections = [NSMutableArray array];
    for (NSDictionary *collection in resultCollections)
    {
        CollectionBean *collectionBean = [[CollectionBean alloc] initWithJson:collection];
        [_relatedCollections addObject:collectionBean];
    }

    NSDictionary *userCollection = [json objectForKey:@"userCollections"];
    if ([YokoAPIUtils checkNullDictionary:userCollection])
    {
        self.userCollections = [NSMutableArray array];
        NSEnumerator *enumerator = [userCollection keyEnumerator];
        id key;
        while ( (key = [enumerator nextObject]) )
        {
            NSDictionary *subDictionary = [userCollection objectForKey:key];
            CollectionBean *collectionBean = [[CollectionBean alloc] initWithJson:subDictionary];
            [_userCollections addObject:collectionBean];
        }
    }

    NSArray *resultConnections = [related objectForKey:@"connections"];
    self.connections = [NSMutableArray array];
    for (NSDictionary *connection in resultConnections)
    {
        if ([YokoAPIUtils stringCheckInDictionary:connection key:@"type"] == @"Restaurant")
        {
            RestaurantBean *connectionBean = [[RestaurantBean alloc] initWithJson:connection];
            [_connections addObject:connectionBean];
        }
        else
        {
            RecipeBean *connectionBean = [[RecipeBean alloc] initWithJson:connection];
            [_connections addObject:connectionBean];
        }
    }

    NSArray *resultComments = [[json objectForKey:@"comments"] objectForKey:@"comments"];
    self.comments = [NSMutableArray array];
    for (NSDictionary *comment in resultComments)
    {
        CommentBean *commentBean = [[CommentBean alloc] initWithJson:comment];
        [_comments addObject:commentBean];
    }

    //To-Do, need to validate and do the testing for this API
    //response json object should be restaurantJson
//    id timeDinning = [json objectForKey:@"hours"];
    id timeDinning = [restaurantJson objectForKey:@"hours"];
    if ([YokoAPIUtils checkNullArray:timeDinning])
    {
        NSMutableArray *dinningTimeObject = [NSMutableArray array];
        for (NSDictionary *dict in timeDinning)
        {
            NSArray *days = [dict objectForKey:@"days"];
            NSString *day = [NSString stringWithFormat:@"%@-%@",[self getDay:[days objectAtIndex:0]],[self getDay:[days objectAtIndex:1]]];
            NSArray *hours = [[dict objectForKey:@"hours"] objectAtIndex:0];
            self.lunchHour = [[TimeBean alloc] initWithOpenTime:[hours objectAtIndex:0] andCloseTime:[hours objectAtIndex:1]];
            NSString *time = [NSString stringWithFormat:@"%@.%@am-%@.%@pm",_lunchHour.openTime.hr12,_lunchHour.openTime.min,_lunchHour.closeTime.hr12,_lunchHour.openTime.min];
            NSString *hoursDinning = [NSString stringWithFormat:@"%@ %@",day,time];
            [dinningTimeObject addObject:hoursDinning];
        }

        _dinningTime = NSLocalizedString(@"Hours", nil);
        for (NSString *timeStr in dinningTimeObject)
        {
            _dinningTime = [_dinningTime stringByAppendingFormat:@"%@;",timeStr];
        }
    }

    //To-Do, need to validate and do the testing for this API
    if ([YokoAPIUtils checkNullArray:[json objectForKey:@"nearby"]])
    {
        NSArray *nearbyRestaurant = [json objectForKey:@"nearby"];
        self.nearby = [NSMutableArray array];
        for (NSDictionary *dict in nearbyRestaurant)
        {
            RestaurantBean *bean = [[RestaurantBean alloc] initWithJson:dict];
            NSDictionary *location = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"lat"],@"lat",[dict objectForKey:@"long"],@"lng",@"",@"address", nil];

            LocationBean *locBean = [[LocationBean alloc] initWithJson:location];
            bean.locationBean = locBean;
            bean.type = @"Restaurant";
            [self.nearby addObject:bean];
        }
    }
}


/**
 *	@brief This is used for parsing JSON data.
 *
 *  @param day string of day name
 *  @return returns string of day
 */
- (NSString *) getDay:(NSString *)day
{
    NSString *str = nil;
    switch ([day integerValue])
    {
        case 1:
            str = @"Mon";
            break;
        case 2:
            str = @"Tue";
            break;
        case 3:
            str = @"Wed";
            break;
        case 4:
            str = @"Thu";
            break;
        case 5:
            str = @"Fri";
            break;
        case 6:
            str = @"Sat";
            break;
        case 7:
            str = @"Sun";
            break;
        default:
            break;
    } /* switch */

    return str;
}


@end
