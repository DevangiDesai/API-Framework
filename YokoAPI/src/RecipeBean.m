//
//  RecipeBean.m
//  YokoMobile
//
//  Created by Devangi Desai on 04/12/12.
//  Copyright (c) 2012 Devangi. All rights reserved.
//

#import "RecipeBean.h"
#import "YokoAPIUtils.h"
#import "RestaurantBean.h"

@implementation RecipeBean

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
    self.authorId = [YokoAPIUtils stringCheckInDictionary:json key:@"authorId"];
    NSDictionary *recipeJson;
    NSDictionary *recipe = [json objectForKey:@"recipe"];
    if (recipe)
    {
        recipeJson = recipe;
    }
    else
    {
        recipeJson = json;
    }

    [super loadBaseJSON:recipeJson];
    self.cuisine = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"cuisine"];
    self.complexity = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"complexity"];
    self.methods = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"methods"];
    self.allergies = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"allergies"];
    self.dietaryConsiderations = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"dietaryConsiderations"];
    self.healthFactor = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"healthFactor"];
    self.yields = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"yields"];
    self.prepTime = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"prepTime"];
    self.cookTime = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"cookTime"];
    self.source = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"source"];
    self.externalUrl = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"externalUrl"];

    NSDictionary *head = [json objectForKey:@"head"];
    self.canonical = [YokoAPIUtils stringCheckInDictionary:head key:@"canonical"];
    self.ogTitle = [YokoAPIUtils stringCheckInDictionary:[head objectForKey:@"content"] key:@"ogTitle"];
    self.ogDescription = [YokoAPIUtils stringCheckInDictionary:[head objectForKey:@"content"] key:@"ogDescription"];

    self.slug = [YokoAPIUtils stringCheckInDictionary:recipeJson key:@"slug"];

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
    self.descriptionKey = [YokoAPIUtils stringCheckInDictionary:json key:@"descriptionKey"];
    self.lastDiditMessageKey = [YokoAPIUtils stringCheckInDictionary:json key:@"lastDiditMessageKey"];

    self.ctaText = [YokoAPIUtils stringCheckInDictionary:[json objectForKey:@"ctaMessageKeys"] key:@"ctaText"];
    self.ctaButton = [YokoAPIUtils stringCheckInDictionary:[json objectForKey:@"ctaMessageKeys"] key:@"ctaButton"];

    self.canComment = [[YokoAPIUtils stringCheckInDictionary:json key:@"canComment"] boolValue];
    self.ingredients = [NSArray arrayWithArray:[recipeJson objectForKey:@"ingredients"]];
    self.steps = [NSArray arrayWithArray:[recipeJson objectForKey:@"steps"]];

    self.imageAttributesBean = [[ImageAttributesBean alloc] initWithJson:[recipe objectForKey:@"imageAttrs"]];

    self.userBean = [[UserBean alloc] initWithJson:[json objectForKey:@"profile"]];
    self.createdDate = [[DateBean alloc] initWithJson:[recipeJson objectForKey:@"createdDate"]];
    self.updatedDate = [[DateBean alloc] initWithJson:[recipeJson objectForKey:@"updatedDate"]];

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
        if ([[YokoAPIUtils stringCheckInDictionary:connection key:@"type"] isEqualToString:@"Restaurant"])
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
}


@end
