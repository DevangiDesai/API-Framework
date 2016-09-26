//
//  API.h
//  YokoAPI
//
//  Created by Devangi 21/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#ifndef YokoAPI_API_h
#define YokoAPI_API_h

#define  mobileDev 0
#define  staging 1
#define  dev0 0
#define  dev1 0
#define  live 0
#define  dev4 0
#define  dev5 0

#if staging

#  define YOKO_BASE_URL @ "http://staging.test.com"

#  define YOKO_COOKIE_KEY @ "xn_id_yoko-staging-foodie"

#elif mobileDev

#  define YOKO_BASE_URL @ "http://dev0.test.com/"

#  define YOKO_COOKIE_KEY @ "xn_id_yoko-internal-mobile"

#elif dev0

#  define YOKO_BASE_URL @ "http://dev0.test.com/"

#  define YOKO_COOKIE_KEY @ "xn_id_yoko-internal-mobile"

#elif dev1

#  define YOKO_BASE_URL @ "http://dev1.foodie.com/"

#  define YOKO_COOKIE_KEY @ "xn_id_yoko-internal-aclu0f"

#elif dev4

#  define YOKO_BASE_URL @ "http://dev4.foodie.com/"

#  define YOKO_COOKIE_KEY @ "xn_id_yoko-internal-aclu0f"

#elif dev5

#  define YOKO_BASE_URL @ "http://dev5.foodie.com/"

#  define YOKO_COOKIE_KEY @ "xn_id_yoko-internal-dev5"

#elif live

#  define YOKO_BASE_URL @ "http://www.foodie.com/"

#  define YOKO_COOKIE_KEY @ "xn_id_yokofoodie"
#endif // if staging

#define COOKIE_DEFAULT YOKO_COOKIE_KEY

#define YOKO_DISCOVER @ "api/v1/discover"

#define YOKO_PROFILE @ "api/v1/profile/detail"

#define YOKO_COLLECTION_DETAIL @ "api/mobile/v1/collection"

#define YOKO_RECIPE_DETAIL @ "api/v1/recipe/detail"

#define YOKO_RESTAURANT_DETAIL @ "api/v1/restaurant/detail"

#define YOKO_FOLLOWERS @ "api/v1/profile/followers"

#define YOKO_FOLLOWINGS @ "api/v1/profile/following"

#define YOKO_COLLECT_ACTIVITIES @ "api/v1/%@/collect/activities"

#define YOKO_LOVE_ACTIVITIES @ "api/v1/%@/love/activities"

#define YOKO_DIDIT_ACTIVITIES @ "api/v1/%@/didit/activities"

#define YOKO_COLLECTION_LIST @ "api/mobile/v1/collection/user"

#define YOKO_COMMENT_LIST @ "api/v1/comment/list"

#define YOKO_FACEBOOK_SIGNIN @ "api/v1/auth/facebook"

#define YOKO_TWITTER_SIGNIN @ "api/v1/auth/twitter"

#define YOKO_SOCIAL_SIGNIN @ "api/v1/auth/socialSignIn"

#define YOKO_SOCIAL_SIGNUP @ "api/v1/auth/socialSignUp"

#define YOKO_LOVE_UPDATE @ "api/v1/love/update"

#define YOKO_DIDIT_UPDATE @ "api/v1/didit"

#define YOKO_POST_COLLECTION @ "api/v1/collection/add"

#define YOKO_COMMENT_SAVE @ "api/v1/comment/save"

#define YOKO_NOTIFICATION_COUNT @ "api/v1/notification/count"

//NOTE: This is not used now.
#define YOKO_All_NOTIFICATION @ "api/v1/profile/notifications"

#define YOKO_UNREAD_All_NOTIFICATION @ "api/v1/notification/unread"

// This is post method
#define YOKO_READ_All_NOTIFICATION @ "api/v1/notification/read"

#define YOKO_FOLLOW_USER @ "api/v1/follow/follow"

#define YOKO_UNFOLLOW_USER @ "api/v1/follow/unfollow"

#define YOKO_IMAGE_UPLOAD @ "api/v1/image/upload"
#endif // ifndef YokoAPI_API_h
