//
//  YokoAPI.m
//  YokoAPI
//
//  Created by Devangi on 6/7/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "YokoAPI.h"
#import "YokoAFNetAPIManager.h"
#import "API.h"
#import "YokoAPIUtils.h"
#import "MMConstant.h"
#import "DiscoverJsonParser.h"
#import "ProfileJsonParser.h"
#import "RecipeJsonParser.h"
#import "RestaurantJsonParser.h"
#import "FollowingFollowerJsonParser.h"
#import "ActivityEventParser.h"
#import "CollectionJsonParser.h"
#import "CommentListJsonParser.h"
#import "StatusJsonParser.h"
#import "AddCollectionJsonParser.h"
#import "YokoAPIUtils.h"
#import "LoveBean.h"
#import "ImageUploadJsonParser.h"
#import "ImageAttributesBean.h"
#import "GTMNSString+URLArguments.h"
#import "YokoSocialAPI.h"
#import "NotificationDetailJsonParser.h"

@implementation YokoAPI

+ (id) sharedInstance
{
    static dispatch_once_t pred;
    static YokoAPI *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[YokoAPI alloc] init];
    }


                  );
    return sharedInstance;
}


- (id) init
{
    self = [super init];

    if (self)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    }

    return self;
}


+ (NSString *) baseURL
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *domain = [defaults objectForKey:@"apiBaseURL"];

    if (domain)
    {
        return [NSString stringWithFormat:@"http://%@", domain];
    }

    return YOKO_BASE_URL;
}


+ (NSString *) cookieIdentifier
{
    NSString *domain = [YokoAPI baseURL];

    //TODO: Refactor and find a better place for these definitions.
    if (domain)
    {
        if ([domain isEqualToString:@"http://dev0.test.com"] || [domain isEqualToString:@"http://dev5.test.com"])
        {
            return @"xn_id_yoko-internal-mobile";
        }
        else if ([domain isEqualToString:@"http://staging.test.com"])
        {
            return @"xn_id_yoko-staging-foodie";
        }
        else if ([domain isEqualToString:@"http://alpha.test.com"] || [domain isEqualToString:@"http://beta.test.com"])
        {
            return @"xn_id_yokofoodie";
        }
    }

    return COOKIE_DEFAULT;
}


/**
 * @brief This method is used for connect with server to GET or POST data
 * @note Looks unused now.
 * @param postParam used for POST data parameter
 * @param requestType used for POST OR GET
 * @param api used for API Url to call.
 * @param parameters used for GET data parameter
 * @param success used for success response
 * @param failure used for failure response
 */

- (void) connectWithServer:(NSString *)postParam
               requestType:(NSString *)type
                       api:(NSString *)api
                parameters:(NSDictionary *)params
                   success:( void ( ^)(NSDictionary *objects) )successBlock
                   failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:type dataToPost:postParam headerParam:nil parameters:params path:api forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        successBlock(responseObject);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for POST love activity
 * @param contentID used for contentdID
 * @param action used for  set love action
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) postLoveData:(NSString *)contentID
               action:(NSString *)action
                param:(NSDictionary *)params
              success:( void ( ^)(LoveBean *bean) )successBlock
              failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    NSString *postData = [NSString stringWithFormat:@"content_id=%@&action=%@",[contentID gtm_stringByEscapingForURLArgument],[action gtm_stringByEscapingForURLArgument]];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    //when we set header here from our plist, aka user default, the second time login server will send back 404 error, hence we set as nil
    //all the follwing methods apply the same
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:postData headerParam:nil parameters:params path:YOKO_LOVE_UPDATE forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        LoveBean *obj = (LoveBean *)[StatusJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        [YokoAPIUtils logoutIfServerError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for Did It activity
 * @param contentID used for contentdID
 * @param description used for commenet data
 * @param imageURL is used for image url string for post
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) postDidItData:(NSString *)contentID
           description:(NSString *)description
              imageURL:(NSString *)imageURL
                 param:(NSDictionary *)params
               success:( void ( ^)(BaseBean *bean) )successBlock
               failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    if (imageURL == (id)[NSNull null] || imageURL.length == 0 || imageURL == nil)
    {
        imageURL = @"";
    }

    NSString *postData = [NSString stringWithFormat:@"content_id=%@&description=%@&image_url=%@",[contentID gtm_stringByEscapingForURLArgument],[description gtm_stringByEscapingForURLArgument],[imageURL gtm_stringByEscapingForURLArgument]];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:postData headerParam:nil parameters:params path:YOKO_DIDIT_UPDATE forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        BaseBean *obj = (BaseBean *)[StatusJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        [YokoAPIUtils logoutIfServerError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for collection  activity
 * @brief comment is user for comments on the collection
 * @brief collectionID is user for collection ID
 * @param contentID used for contentdID
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) postCollectionData:(NSString *)comment
               collectionID:(NSString *)collectionID
             collectionName:(NSString *)collectionName
                  contentID:(NSString *)contentID
                      param:(NSDictionary *)params
                    success:( void ( ^)(NSArray *objects) )successBlock
                    failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock;

{
    NSString *postData = [NSString stringWithFormat:@"annotation=%@&collection_id=%@&collection_name=%@&content_id=%@",[comment gtm_stringByEscapingForURLArgument],[collectionID gtm_stringByEscapingForURLArgument],[collectionName gtm_stringByEscapingForURLArgument],[contentID gtm_stringByEscapingForURLArgument]];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:postData headerParam:nil parameters:params path:YOKO_POST_COLLECTION forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *obj = [AddCollectionJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        [YokoAPIUtils logoutIfServerError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}

/**
 * @brief This method is used for post comment activity
 * @brief comment is user for post comment text data
 * @brief objectID is user for objectID ID of the perticular activity
 * @note Looks unused now.
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) postCommentData:(NSString *)comment
                objectID:(NSString *)objectID
                   param:(NSDictionary *)params
                 success:( void ( ^)(NSArray *objects) )successBlock
                 failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock;
{
    NSString *postData = [NSString stringWithFormat:@"comment=%@&objectId=%@",[comment gtm_stringByEscapingForURLArgument],[objectID gtm_stringByEscapingForURLArgument]];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:postData headerParam:nil parameters:params path:YOKO_COMMENT_SAVE forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *obj = [CommentListJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}

/**
 * @brief This method is used for follow user activity
 * @brief followerId is used for logged in user ID
 * @brief followeeId is used for follow user ID
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) postFollow:(NSString *)followerId
         followeeId:(NSString *)followeeId
            success:( void ( ^)(UserBean *bean) )successBlock
            failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSString *postData = [NSString stringWithFormat:@"followeeId=%@&followerId=%@",[followeeId gtm_stringByEscapingForURLArgument],[followerId gtm_stringByEscapingForURLArgument]];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:postData headerParam:nil parameters:nil path:YOKO_FOLLOW_USER forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *userBeans = [FollowingFollowerJsonParser parseJSON:responseObject];
        UserBean *obj = (UserBean *)[userBeans firstObject];
        obj.following = YES;
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for unfollow user activity
 * @brief followerId is used for logged in user ID
 * @brief followeeId is used for unfollow user ID
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) postUnFollow:(NSString *)followerId
           followeeId:(NSString *)followeeId
              success:( void ( ^)(UserBean *bean) )successBlock
              failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSString *postData = [NSString stringWithFormat:@"followeeId=%@&followerId=%@",[followeeId gtm_stringByEscapingForURLArgument],[followerId gtm_stringByEscapingForURLArgument]];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:postData headerParam:nil parameters:nil path:YOKO_UNFOLLOW_USER forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *userBeans = [FollowingFollowerJsonParser parseJSON:responseObject];
        UserBean *obj = (UserBean *)[userBeans firstObject];
        obj.following = NO;
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get discover everything time line data
 * @brief type is used showing the data like,restaurant. recipe and everything
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getDiscover:(NSString *)type
              filter:(NSString *)filter
          timeMarker:(NSString *)timeMarker
            idMarker:(NSString *)idMarker
             success:( void ( ^)(NSArray *objects, NSDictionary *oldest, NSString *timeMarker) )successBlock
             failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    if ([type compare:@"everything" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        type = @"";
    }

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:type, @"type", filter, @"filter", idMarker, @"idMarker", timeMarker, @"timeMarker", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_DISCOVER forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *objects = [DiscoverJsonParser parseJSON:responseObject];
        NSDictionary *oldest = [responseObject objectForKey:@"oldest"];
        NSString *timeMarker = [responseObject objectForKey:@"timeMarker"];
        successBlock(objects, oldest, timeMarker);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get profile information of user
 * @brief paramId is used for user id of selected user
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getProfile:(NSString *)paramId
            success:( void ( ^)(UserBean *bean) )successBlock
            failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = nil;
    if (paramId != (id)[NSNull null] && paramId.length != 0 && paramId != nil)
    {
        params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", nil];
    }

    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_PROFILE forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        UserBean *obj = (UserBean *)[ProfileJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get recipe details
 * @brief paramId is used for recipe Id of selected recipe
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getRecipeById:(NSString *)paramId
               success:( void ( ^)(RecipeBean *bean) )successBlock
               failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_RECIPE_DETAIL forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        RecipeBean *obj = (RecipeBean *)[RecipeJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get restaurant details
 * @brief paramId is used for restaurant Id of selected restaurant
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getRestaurantById:(NSString *)paramId
                   success:( void ( ^)(RestaurantBean *bean) )successBlock
                   failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_RESTAURANT_DETAIL forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        RestaurantBean *obj = (RestaurantBean *)[RestaurantJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get collection details
 * @brief paramId is used for collection Id of selected collection
 * @note Looks unused now.
 * @param success used for success response. Used the NSDisctionary to get the response in success block. As we need to extract some infromation in Activity Bean and some infomration directly to show the data in CollectionDetailView.
 * @param failure used for failure response
 */
- (void) getCollectionById:(NSString *)paramId
                timeMarker:(NSString *)timeMarker
                  idMarker:(NSString *)idMarker
                   success:( void ( ^)(NSDictionary *dictObj, NSDictionary *oldest, NSString *timeMarker) )successBlock
                   failure:( void (^) (AFHTTPRequestOperation *operation, NSError *error) )failureBlock;
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", idMarker, @"idMarker", timeMarker, @"timeMarker", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_COLLECTION_DETAIL forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *dictionaryObj = responseObject;
        NSDictionary *oldest = [responseObject objectForKey:@"oldest"];
        NSString *timeMarker = [responseObject objectForKey:@"timeMarker"];
        successBlock(dictionaryObj, oldest, timeMarker);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}

/**
 * @brief This method is used for get all followers details of logged in user
 * @brief paramId is used for logged in users Id
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getFollowersByUserId:(NSString *)paramId
                   timeMarker:(NSString *)timeMarker
                     idMarker:(NSString *)idMarker
                      success:( void ( ^)(NSArray *objects, NSDictionary *oldest, NSString *timeMarker) )successBlock
                      failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", idMarker, @"idMarker", timeMarker, @"timeMarker", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_FOLLOWERS forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *oldest = [responseObject objectForKey:@"oldest"];
        NSString *timeMarker = [responseObject objectForKey:@"timeMarker"];
        NSArray *objects = [FollowingFollowerJsonParser parseJSON:responseObject];
        successBlock(objects, oldest, timeMarker);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get all following details of logged in user
 * @brief paramId is used for logged in users Id
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getFollowingsByUserId:(NSString *)paramId
                    timeMarker:(NSString *)timeMarker
                      idMarker:(NSString *)idMarker
                       success:( void ( ^)(NSArray *objects, NSDictionary *oldest, NSString *timeMarker) )successBlock
                       failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", idMarker, @"idMarker", timeMarker, @"timeMarker", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_FOLLOWINGS forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *oldest = [responseObject objectForKey:@"oldest"];
        NSString *timeMarker = [responseObject objectForKey:@"timeMarker"];
        NSArray *objects = [FollowingFollowerJsonParser parseJSON:responseObject];
        successBlock(objects, oldest, timeMarker);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get all collect activities
 * @brief netPath is used for to show perticular path like restatuarant/recipe/profile
 * @brief paramId is used  for to show the details as per the  activity ID(like restatuarant/recipe/profile)
 * @param success used for success response
 * @param failure used for failure response
 */

- (void) getCollectActivities:(NSString *)netPath
                      paramId:(NSString *)paramId
                     idMarker:(NSString *)idMarker
                   timeMarker:(NSString *)timeMarker
                         type:(NSString *)type
                      success:( void ( ^)(NSArray *objects, NSDictionary *oldestParams) )successBlock
                      failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    NSString *urlPath = [NSString stringWithFormat:YOKO_COLLECT_ACTIVITIES, netPath];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", type, @"type", idMarker, @"idMarker", timeMarker, @"timeMarker", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:urlPath forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *requestParam = [self getPagingValues:responseObject];
        NSArray *objects = [ActivityEventParser parseJSON:responseObject type:netPath action:@"collect"];
        successBlock(objects, requestParam);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get all love activities
 * @brief netPath is used for to show perticular path like restatuarant/recipe/profile
 * @brief paramId is used  for to show the details as per the  activity ID(like restatuarant/recipe/profile)
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getLoveActivities:(NSString *)netPath
                   paramId:(NSString *)paramId
                  idMarker:(NSString *)idMarker
                timeMarker:(NSString *)timeMarker
                      type:(NSString *)type
                   success:( void ( ^)(NSArray *objects, NSDictionary *oldestParams) )successBlock
                   failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    NSString *urlPath = [NSString stringWithFormat:YOKO_LOVE_ACTIVITIES, netPath];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", type, @"type", idMarker, @"idMarker", timeMarker, @"timeMarker", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:urlPath forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *requestParam = [self getPagingValues:responseObject];
        NSArray *objects = [ActivityEventParser parseJSON:responseObject type:netPath action:@"love"];
        successBlock(objects, requestParam);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for get all Did It activities
 * @brief netPath is used for to show perticular path like restatuarant/recipe/profile
 * @brief paramId is used  for to show the details as per the  activity ID(like restatuarant/recipe/profile)
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getDiditActivities:(NSString *)netPath
                    paramId:(NSString *)paramId
                   idMarker:(NSString *)idMarker
                 timeMarker:(NSString *)timeMarker
                       type:(NSString *)type
                    success:( void ( ^)(NSArray *objects, NSDictionary *oldestParams) )successBlock
                    failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    NSString *urlPath = [NSString stringWithFormat:YOKO_DIDIT_ACTIVITIES, netPath];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", type, @"type", idMarker, @"idMarker", timeMarker, @"timeMarker", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:urlPath forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *requestParam = [self getPagingValues:responseObject];
        NSArray *objects = [ActivityEventParser parseJSON:responseObject type:netPath action:@"didit"];
        successBlock(objects, requestParam);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for to show all collection list as per the selected user ID
 * @brief paramId is used  for to get the details as per the  selected user id
 * @brief loadmenbers is for loading collection members as per user id
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getCollectionsByUserId:(NSString *)paramId
                    loadMembers:(BOOL)loadMembers
                        success:( void ( ^)(NSArray *objects) )successBlock
                        failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = nil;

    NSString *shouldLoadMembers = (loadMembers) ? @"true" : @"false";

    if (paramId != (id)[NSNull null] && paramId.length != 0 && paramId != nil)
    {
        params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", shouldLoadMembers, @"loadMembers", nil];
    }
    else
    {
        params = [NSDictionary dictionaryWithObjectsAndKeys:shouldLoadMembers, @"loadMembers", nil];
    }

    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_COLLECTION_LIST forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *objects = [CollectionJsonParser parseJSON:responseObject];
        successBlock(objects);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        // Somehow, API returns HTTP 204 status code on session expired. Then this part will not be called on expiration. I think server should return something error codes if content is not available. - Takashi
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for to show all comment list as per the selected object id(like particular restatuarant or recipe)
 * @brief paramId is used  for to get the details as per the  object Id
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getCommentsByObjectId:(NSString *)paramId
                       success:( void ( ^)(NSArray *objects) )successBlock
                       failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:paramId, @"id", nil];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:params path:YOKO_COMMENT_LIST forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *objects = [CommentListJsonParser parseJSON:responseObject];
        successBlock(objects);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for to show the logged in users information
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getLoggedInUserProfile:( void ( ^)(UserBean *bean) )successBlock
                        failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:nil path:YOKO_PROFILE forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        UserBean *obj = (UserBean *)[ProfileJsonParser parseJSON:responseObject];
        [YokoAPIUtils setValueInNSUserDefault:obj.coreObjectId withKey:YOKO_LOGGEDINUSERID];
        [YokoAPIUtils setValueInNSUserDefault:obj.slug withKey:YOKO_LOGGEDINUSER_SLUG];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        [YokoAPIUtils logoutIfServerError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for to show the logged in users id
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getLoggedInUserId:( void ( ^)(NSString *userId) )successBlock
                   failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:nil path:YOKO_PROFILE forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        UserBean *obj = (UserBean *)[ProfileJsonParser parseJSON:responseObject];
        [YokoAPIUtils setValueInNSUserDefault:obj.coreObjectId withKey:YOKO_LOGGEDINUSERID];
        successBlock(obj.coreObjectId);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logoutIfServerError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for to get the notification count of logged in user
 * @note Looks unused now.
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) getNotificationCount:( void ( ^)(NSObject *object) )successBlock
                      failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:nil path:YOKO_NOTIFICATION_COUNT forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSObject *obj = [ProfileJsonParser parseJSON:responseObject];
        successBlock(obj);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for to get the notification details of logged in user
 * @param success this return notification beans array in the response
 * @param failure used for failure response
 */
- (void) getNotificationDetail:( void ( ^)(NSArray *objects) )successBlock
                       failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:nil path:YOKO_UNREAD_All_NOTIFICATION forFeedType:EJSON];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *notifications = [NotificationDetailJsonParser parseJSONForCannes:responseObject];
        successBlock(notifications);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is used for to upload image
 * @param success used for success response
 * @param failure used for failure response
 */
- (void) uploadImage:(NSData *)uploadImageData
             success:( void ( ^)(ImageAttributesBean *bean) )successBlock
             failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSDictionary *multiPartData = [NSDictionary dictionaryWithObjectsAndKeys:@"file",@"avatar",@"temp.jpeg",@"fileName",@"image/jpeg",@"mimeType",nil];

    AFHTTPRequestOperation *requestOperation = [manager getRequestOperationForFileUpload:[YokoAPI baseURL] dataToUpload:uploadImageData delegate:self parameters:nil multipartData:multiPartData forFeedType:EJSON headerParam:nil path:YOKO_IMAGE_UPLOAD];

    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        ImageAttributesBean *bean = (ImageAttributesBean *)[ImageUploadJsonParser parseJSON:responseObject];
        successBlock(bean);
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        [YokoAPIUtils logoutIfServerError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


- (NSDictionary *) getPagingValues:(NSDictionary *)response
{
    NSDictionary *oldest = [response objectForKey:@"oldest"];
    NSDictionary *params;
    if (oldest)
    {
        params = [NSDictionary dictionaryWithObjectsAndKeys:[oldest objectForKey:@"id"],@"idMarker",[oldest objectForKey:@"time"],@"timeMarker",nil];
    }

    return params;
}


@end
