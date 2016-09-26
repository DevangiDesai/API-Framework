//
//  YokoAPI.h
//  YokoAPI
//
//  Created by Devangi on 6/7/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
@class LoveBean;
@class UserBean;
@class BaseBean;
@class RecipeBean;
@class RestaurantBean;
@class ActivityBean;
@class ImageAttributesBean;

@interface YokoAPI : NSObject

+ (id)sharedInstance;

+ (NSString *)baseURL;
+ (NSString *)cookieIdentifier;

/**
 * @brief This method is used for get discover everything time line data
 * @brief type is used showing the data like,restaurant. recipe and everything
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getDiscover:(NSString *)type
             filter:(NSString *)filter
         timeMarker:(NSString *)timeMarker
           idMarker:(NSString *)idMarker
            success:( void(^) (NSArray * objects, NSDictionary * oldest, NSString * timeMarker) ) successBlock
            failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get profile information of user
 * @brief paramId is used for user id of selected user
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getProfile:(NSString *)paramId
           success:( void(^) (UserBean * bean) ) successBlock
           failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get recipe details
 * @brief paramId is used for recipe Id of selected recipe
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getRecipeById:(NSString *)paramId
              success:( void(^) (RecipeBean * bean) ) successBlock
              failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get restaurant details
 * @brief paramId is used for restaurant Id of selected restaurant
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getRestaurantById:(NSString *)paramId
                  success:( void(^) (RestaurantBean * bean) ) successBlock
                  failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get collection details
 * @brief paramId is used for collection Id of selected collection
 * @note Looks unused now.
 * @param success used for success response. Used the NSDisctionary to get the response in success block. As we need to extract some infromation in Activity Bean and some infomration directly to show the data in CollectionDetailView.
 * @param failure used for failure response
 */
- (void)getCollectionById:(NSString *)paramId
               timeMarker:(NSString *)timeMarker
                 idMarker:(NSString *)idMarker
                  success:( void( ^) (NSDictionary * dictObj, NSDictionary * oldest, NSString * timeMarker) ) successBlock
                  failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get all followers details of logged in user
 * @brief paramId is used for logged in users Id
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getFollowingsByUserId:(NSString *)paramId
                   timeMarker:(NSString *)timeMarker
                     idMarker:(NSString *)idMarker
                      success:( void( ^) (NSArray * objects, NSDictionary * oldest, NSString * timeMarker) ) successBlock
                      failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get all following details of logged in user
 * @brief paramId is used for logged in users Id
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getFollowersByUserId:(NSString *)paramId
                  timeMarker:(NSString *)timeMarker
                    idMarker:(NSString *)idMarker
                     success:( void( ^) (NSArray * objects, NSDictionary * oldest, NSString * timeMarker) ) successBlock
                     failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get all collect activities
 * @brief netPath is used for to show perticular path like restatuarant/recipe/profile
 * @brief paramId is used  for to show the details as per the  activity ID(like restatuarant/recipe/profile)
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getCollectActivities:(NSString *)netPath
                     paramId:(NSString *)paramId
                    idMarker:(NSString *)idMarker
                  timeMarker:(NSString *)timeMarker
                        type:(NSString *)type
                     success:( void(^) (NSArray * objects, NSDictionary * oldestParams) ) successBlock
                     failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for get all love activities
 * @brief netPath is used for to show perticular path like restatuarant/recipe/profile
 * @brief paramId is used  for to show the details as per the  activity ID(like restatuarant/recipe/profile)
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getLoveActivities:(NSString *)netPath
                  paramId:(NSString *)paramId
                 idMarker:(NSString *)idMarker
               timeMarker:(NSString *)timeMarker
                     type:(NSString *)type
                  success:( void(^) (NSArray * objects, NSDictionary * oldestParams) ) successBlock
                  failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for get all Did It activities
 * @brief netPath is used for to show perticular path like restatuarant/recipe/profile
 * @brief paramId is used  for to show the details as per the  activity ID(like restatuarant/recipe/profile)
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getDiditActivities:(NSString *)netPath
                   paramId:(NSString *)paramId
                  idMarker:(NSString *)idMarker
                timeMarker:(NSString *)timeMarker
                      type:(NSString *)type
                   success:( void(^) (NSArray * objects, NSDictionary * oldestParams) ) successBlock
                   failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for to show all collection list as per the selected user ID
 * @brief paramId is used  for to get the details as per the  selected user id
 * @brief loadmenbers is for loading collection members as per user id
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getCollectionsByUserId:(NSString *)paramId
                   loadMembers:(BOOL)loadMembers
                       success:( void(^) (NSArray * objects) ) successBlock
                       failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for to show all comment list as per the selected object id(like particular restatuarant or recipe)
 * @brief paramId is used  for to get the details as per the  object Id
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getCommentsByObjectId:(NSString *)paramId
                      success:( void(^) (NSArray * objects) ) successBlock
                      failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for to show the logged in users information
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getLoggedInUserProfile:( void( ^) (UserBean * bean) ) successBlock
                       failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for to get the notification count of logged in user
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getNotificationCount:( void( ^) (NSObject * object) ) successBlock
                     failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for to get the notification details of logged in user
 * @param success this return notification beans array in the response
 * @param failure used for failure response
 */
- (void)getNotificationDetail:( void( ^) (NSArray * objects) ) successBlock
                      failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for POST love activity
 * @param contentID used for contentdID
 * @param action used for  set love action
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)postLoveData:(NSString *)contentID
              action:(NSString *)action
               param:(NSDictionary *)params
             success:( void( ^) (LoveBean * bean) ) successBlock
             failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for Did It activity
 * @param contentID used for contentdID
 * @param description used for commenet data
 * @param imageURL is used for image url string for post
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)postDidItData:(NSString *)contentID
          description:(NSString *)description
             imageURL:(NSString *)imageURL
                param:(NSDictionary *)param
              success:( void( ^) (BaseBean * bean) ) successBlock
              failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for collection  activity
 * @brief comment is user for comments on the collection
 * @brief collectionID is user for collection ID
 * @param contentID used for contentdID
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)postCollectionData:(NSString *)comment collectionID:(NSString *)collectionID
            collectionName:(NSString *)collectionName
                 contentID:(NSString *)contentID
                     param:(NSDictionary *)params
                   success:( void( ^) (NSArray * objects) ) successBlock
                   failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for post comment activity
 * @brief comment is user for post comment text data
 * @brief objectID is user for objectID ID of the perticular activity
 * @param params used for additional parameter
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)postCommentData:(NSString *)comment
               objectID:(NSString *)objectID
                  param:(NSDictionary *)params
                success:( void( ^) (NSArray * objects) ) successBlock
                failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for follow user activity
 * @brief followerId is used for logged in user ID
 * @brief followeeId is used for follow user ID
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)postFollow:(NSString *)followerId
        followeeId:(NSString *)followeeId
           success:( void(^) (UserBean * bean) ) successBlock
           failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;
/**
 * @brief This method is used for unfollow user activity
 * @brief followerId is used for logged in user ID
 * @brief followeeId is used for unfollow user ID
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)postUnFollow:(NSString *)followerId
          followeeId:(NSString *)followeeId
             success:( void(^) (UserBean * bean) ) successBlock
             failure:( void(^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for connect with server to GET or POST data
 * @param postParam used for POST data parameter
 * @param requestType used for POST OR GET
 * @param api used for API Url to call.
 * @param parameters used for GET data parameter
 * @param success used for  getting success response
 * @param failure used for getting failure response
 */
- (void)connectWithServer:(NSString *)postParam
              requestType:(NSString *)type
                      api:(NSString *)api
               parameters:(NSDictionary *)params
                  success:( void( ^) (NSDictionary * objects) ) successBlock
                  failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for to show the logged in users id
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)getLoggedInUserId:( void( ^) (NSString * userId) ) successBlock
                  failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

/**
 * @brief This method is used for to upload image
 * @param success used for success response
 * @param failure used for failure response
 */
- (void)uploadImage:(NSData *)uploadImageData
            success:( void( ^) (ImageAttributesBean * bean) ) successBlock
            failure:( void( ^) (AFHTTPRequestOperation * operation, NSError * error) )failureBlock;

@end
