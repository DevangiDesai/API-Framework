//
//  ViewController.m
//  YokoAPI
//
//  Created by Devangi on 6/7/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "ViewController.h"
#import "YokoAPI.h"
#import "ActivityBean.h"
#import "UserBean.h"
#import "RecipeBean.h"
#import "RestaurantBean.h"
#import "CollectionBean.h"
#import "ActivityEventBean.h"
#import "SocialLoginView.h"
#import "YokoAPIUtils.h"
#import "DiscoverJsonParser.h"
#import "ProfileJsonParser.h"
#import "AuthenticationViewController.h"
#import "UIComponents.h"
#import "API.h"
#import "RecipeJsonParser.h"
#import "RestaurantJsonParser.h"
#import "FollowingFollowerJsonParser.h"
#import "ActivityEventParser.h"
#import "CommentListJsonParser.h"
#import "Constant.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    api = [YokoAPI sharedInstance];
    [self createSocialView];
    [self getDiscoverRestaurant];
    [self getProfile];
    [self getRecipe];
    [self getRestaurant];
    [self getFollowers];
    [self getFollowings];
    [self getCollectActivities];
    [self getLoveActivities];
    [self getDidItActivities];
    [self getComment];
    [self getDataFromAPI];
}


/**
 * @brief This method is used to get Discover restaurant time line.
 */
-(void)getDiscoverRestaurant
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"Restaurant", @"type", @"recent", @"filter", nil];
    [api connectWithServer:nil requestType:@"GET" api:YOKO_DISCOVER parameters:params success:^(NSDictionary *objects) {
        NSLog(@"%@",objects);
        NSArray * obj = [DiscoverJsonParser parseJSON:objects];
        for (ActivityBean * activity in obj)
        {
            NSLog(@"activity: %@", activity.title);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

/**
 * @brief This method is used to get user profile information.
 */
-(void)getProfile
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Yuser:3648", @"id", nil];
    [api connectWithServer:nil requestType:@"GET" api:YOKO_PROFILE parameters:params success:^(NSDictionary *objects) {
        NSDictionary *obj = (NSDictionary *)[ProfileJsonParser parseJSON:objects];
        NSLog(@"%@",obj);
        UserBean *user = (UserBean *) obj;
        NSLog(@"user: %@", user.title);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

/**
 * @brief This method is used to get perticular recipe's details.
 */
-(void)getRecipe
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Recipe:11684", @"id", nil];
    [api connectWithServer:nil requestType:@"GET" api:YOKO_RECIPE_DETAIL parameters:params success:^(NSDictionary *objects) {
        NSDictionary *obj = (NSDictionary*)[RecipeJsonParser parseJSON:objects];
        RecipeBean *recipe = (RecipeBean *) obj;
        NSLog(@"recipe: %@", recipe.title);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
        }];
}

/**
 * @brief This method is used to get perticular restaurant's details.
 */
-(void)getRestaurant
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Restaurant:3213", @"id", nil];
    [api connectWithServer:nil requestType:@"GET" api:YOKO_RESTAURANT_DETAIL parameters:params success:^(NSDictionary *objects) {
        NSDictionary *obj = (NSDictionary *)[RestaurantJsonParser parseJSON:objects];
        RestaurantBean *restaurant = (RestaurantBean *) obj;
        NSLog(@"restaurant: %@", restaurant.title);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",[error localizedDescription]);
                   }];
}

/**
 * @brief This method is used to get collection details.
 */
-(void)getCollection
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Collection:4514",@"id", nil];
    [api connectWithServer:nil requestType:@"GET" api:YOKO_COLLECTION_DETAIL parameters:params success:^(NSDictionary *objects) {
        NSArray *obj = [DiscoverJsonParser parseJSON:objects];
        for (ActivityBean * activity in obj)
        {
            NSLog(@"collection detail: %@", activity.title);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",[error localizedDescription]);
            }];
}

/**
 * @brief This method is used to get all follwer users information
 */
-(void)getFollowers
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Yuser:3648", @"id", nil];    
    [api connectWithServer:nil requestType:@"GET" api:YOKO_FOLLOWERS parameters:params success:^(NSDictionary *objects) {
        NSArray *obj = [FollowingFollowerJsonParser parseJSON:objects];
        for (UserBean * user in obj)
        {
            NSLog(@"Followers: %@", user.title);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"%@",[error localizedDescription]);}];
}

/**
 * @brief This method is used to get all following users information
 */
-(void)getFollowings
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Yuser:3648", @"id", nil];   
    [api connectWithServer:nil requestType:@"GET" api:YOKO_FOLLOWINGS parameters:params success:^(NSDictionary *objects) {
        NSArray *obj = [FollowingFollowerJsonParser parseJSON:objects];
        for (UserBean *user in obj)
        {
            NSLog(@"Followings: %@", user.title);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",[error localizedDescription]);
     }];    
}

/**
 * @brief This method is used to get all collected activitiees
 */
-(void)getCollectActivities
{
    NSString *apiURL = [NSString stringWithFormat:YOKO_COLLECT_ACTIVITIES, @"recipe"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Recipe:11684", @"id", nil];
    [api connectWithServer:nil requestType:@"GET" api:apiURL parameters:params success:^(NSDictionary *objects) {
        NSArray *obj = [ActivityEventParser parseJSON:objects type:apiURL action:@"collect"];

        for (ActivityEventBean *activityEvent in obj)
        {
            NSLog(@"Collect: %@", activityEvent.collectionBean.title);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",[error localizedDescription]);
                   }];
}
/**
 * @brief This method is used to get all love activitiees
 */

-(void)getLoveActivities
{
    NSString *apiURL = [NSString stringWithFormat:YOKO_COLLECT_ACTIVITIES, @"restaurant"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:Restaurant:3213", @"id", nil];
    [api connectWithServer:nil requestType:@"GET" api:apiURL parameters:params success:^(NSDictionary *objects) {
        NSArray *obj = [ActivityEventParser parseJSON:objects type:apiURL action:@"love"];
        NSLog(@"LOVE %@",obj);
        for (ActivityEventBean *activityEvent in obj)
        {
            NSLog(@"Love: %@", activityEvent.userBean.title);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",[error localizedDescription]);
                   }];
}

/**
 * @brief This method is used to get all did it activitiees
 */
-(void)getDidItActivities
{
    NSString *apiURL = [NSString stringWithFormat:YOKO_DIDIT_ACTIVITIES, @"profile"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: @"2025949:Yuser:3648", @"id", nil];
    [api connectWithServer:nil requestType:@"GET" api:apiURL parameters:params success:^(NSDictionary *objects) {
        NSArray *obj = [ActivityEventParser parseJSON:objects type:apiURL action:@"didit"];
        NSLog(@"Dit It %@",obj);
        for (ActivityEventBean *activityEvent in obj)
        {
            NSLog(@"Didit: %@", activityEvent.title);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",[error localizedDescription]);
                   }];
}
/**
 * @brief This method is used to get all comment on perticular activity event
 */
-(void)getComment
{
   NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2025949:ActivityEvent:14401", @"id", nil];
  [api connectWithServer:nil requestType:@"GET" api:YOKO_COMMENT_LIST parameters:params success:^(NSDictionary *objects) {
        NSArray *obj = [CommentListJsonParser parseJSON:objects];
        NSLog(@"comment %@",obj);
        for (CommentBean *comment in obj)
        {
            NSLog(@"Comments: %@", comment.content);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",[error localizedDescription]);
                   }];
}


/**
 * @brief This method is used to get  response from various API.
 */
- (void) getDataFromAPI
{
    [api getDiscover:@"Restaurant" filter:@"recent" success:^(NSArray *objects) {
        
        for (ActivityBean *activity in objects)
        {
            NSLog(@"activity: %@", activity.title);
        }
    }
             failure:^(AFHTTPRequestOperation * operation, NSError *error)
    {
        if(YOKO_DEBUG)
        {
            [UIComponents errorAlert:[error localizedDescription]];
        }
        else
        {
            [NSException raise:@"Invalid data" format:@"Error %@", error];
        }
    }];

    [api getProfile:@"2025952:Yuser:68343" success:^(NSObject *object) {
        UserBean *user = (UserBean *) object;
        NSLog(@"user: %@", user.title);
    }
            failure:^(AFHTTPRequestOperation * operation, NSError *error)
    {
        if(YOKO_DEBUG)
        {
            [UIComponents errorAlert:[error localizedDescription]];
        }
    }
     ];

    [api getRecipeById:@"2025952:Recipe:8080" success:^(NSObject *object) {
        RecipeBean *recipe = (RecipeBean *) object;
        CollectionBean *collection = [recipe.relatedCollections objectAtIndex:0];
        NSLog(@"recipe: %@", recipe.title);
        NSLog(@"collection: %@", collection.title);
    }
               failure:^(AFHTTPRequestOperation * operation, NSError *error)
     {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
    }
     ];

    [api getRestaurantById:@"2025952:Restaurant:1140" success:^(NSObject *object) {
        RestaurantBean *restaurant = (RestaurantBean *) object;
        CommentBean *comment = [restaurant.comments objectAtIndex:0];
        NSLog(@"restaurant: %@", restaurant.title);
        NSLog(@"comments: %@", comment.userBean.title);
    }
                   failure:^(AFHTTPRequestOperation * operation, NSError *error)
     {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
     }
     ];

    [api getCollectionById:@"2025952:Collection:8081" success:^(NSArray *objects) {
        for (ActivityBean *activity in objects)
        {
            NSLog(@"collection detail: %@", activity.title);
        }
    }
                   failure:^(AFHTTPRequestOperation * operation, NSError *error)
    {
        if(YOKO_DEBUG)
        {
            [UIComponents errorAlert:[error localizedDescription]];
        }
    }
     ];

    [api getFollowersByUserId:@"2025952:Yuser:68343" success:^(NSArray *objects) {
        for (UserBean *user in objects)
        {
            NSLog(@"Followings: %@", user.title);
        }
    }
                      failure:^(AFHTTPRequestOperation * operation, NSError *error)
    {
        if(YOKO_DEBUG)
        {
            [UIComponents errorAlert:[error localizedDescription]];
        }
    }
     ];

    [api getFollowingsByUserId:@"2025952:Yuser:68343" success:^(NSArray *objects) {
        for (UserBean *user in objects)
        {
            NSLog(@"Followers: %@", user.title);
        }
    }
                       failure:^(AFHTTPRequestOperation * operation, NSError *error)
     {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
    }];

    [api getCollectActivities:@"recipe" paramId:@"2025952:Recipe:8080" success:^(NSArray *objects) {
        for (ActivityEventBean *activityEvent in objects)
        {
            NSLog(@"Collect: %@", activityEvent.collectionBean.title);
        }
    }
                      failure:^(AFHTTPRequestOperation * operation, NSError *error)
     {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
    }];

    [api getLoveActivities:@"restaurant" paramId:@"2025952:Restaurant:1140" success:^(NSArray *objects) {
        for (ActivityEventBean *activityEvent in objects)
        {
            NSLog(@"Love: %@", activityEvent.userBean.title);
        }
    }
                   failure:^(AFHTTPRequestOperation * operation, NSError *error)
     {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
    }];

    [api getDiditActivities:@"profile" paramId:@"2025952:Yuser:68343" success:^(NSArray *objects) {
        for (ActivityEventBean *activityEvent in objects)
        {
            NSLog(@"Didit: %@", activityEvent.title);
        }
    }
                    failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        if(YOKO_DEBUG)
        {
            [UIComponents errorAlert:[error localizedDescription]];
        }
    }];

    [api getCollectionsByUserId:@"2025952:Yuser:68343" success:^(NSArray *objects) {
        for (CollectionBean *collection in objects)
        {
            NSLog(@"Collection: %@", collection.title);
        }
    }
                        failure:^(AFHTTPRequestOperation * operation, NSError *error)
    {
        if(YOKO_DEBUG)
        {
            [UIComponents errorAlert:[error localizedDescription]];
        }
    }
     ];

    [api getCommentsByObjectId:@"2025952:ActivityEvent:68881" success:^(NSArray *objects) {
        for (CommentBean *comment in objects)
        {
            NSLog(@"Comments: %@", comment.content);
        }
    }
                       failure:^(AFHTTPRequestOperation * operation, NSError *error)
    {
        if(YOKO_DEBUG)
        {
            [UIComponents errorAlert:[error localizedDescription]];
        }
    }
     ];
}
/**
 * @brief This method is used for  create socila login view
 */
- (void) createSocialView
{
    SocialLoginView *socialLoginView = [[SocialLoginView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
    socialLoginView.delegate =self;
    [socialLoginView initWithSubView];
    [self.view addSubview:socialLoginView];
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * @brief This method is used for navigate to the authentication view controller
 */
-(void)createAuthenticationViewController
{
    NSLog(@"createAuthenticationViewController");
    AuthenticationViewController *authenticationViewController = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authenticationViewController animated:YES];

}


@end
