//
//  AuthenticationViewController.m
//  YokoAPI
//
//  Created by Devangi on 05/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "YokoAPI.h"
#import "CommentBean.h"
#import "LoveBean.h"
#import "YokoAPIUtils.h"
#import "Constant.h"
#import "ActivityBean.h"
#import "CollectionBean.h"
#import "UIComponents.h"
#import "API.h"
#import "StatusJsonParser.h"
#import "AddCollectionJsonParser.h"
#import "CommentListJsonParser.h"
#import "NotificationDetailJsonParser.h"
#import "NotificationBean.h"
#import "DiscoverJsonParser.h"
@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }

    return self;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self createAuthenticationButton];
}

/**
 * @brief This method is used to create a button  named as 'Authentication'
 */
- (void) createAuthenticationButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.view.frame.origin.x + 80,self.view.frame.origin.y + 100,150,50);
    [button setTitle:@"Authentication" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

/**
 * @brief This method is used for clickable action of'Authentication' button.
 */
- (void) buttonClicked:(id)sender
{
    api = [YokoAPI sharedInstance];
    [self postLoveAction];
    [self postDidItAction];
    [self postCollectionData];
    [self postCommentData];
    [self followUser];
    [self unfollowUser];
    [self getNotificationCount];
    [self getNotificationDetail];
    [self getDiscover];
    [self postCollectionData];
}


/**
 * @brief This method is used  for LOVE activities.
 */
- (void) postLoveAction
{
    NSString *postData = [NSString stringWithFormat:@"content_id=%@&action=%@",@"2025952:Recipe:8080",@"love"];
    [api connectWithServer:postData requestType:@"POST" api:YOKO_LOVE_UPDATE parameters:nil success:^(NSDictionary *objects)
    {
        NSDictionary *obj = (NSDictionary*)[StatusJsonParser parseJSON:objects];
        NSLog(@"object %@",obj);
        LoveBean *bean = (LoveBean *)obj;
        NSLog (@"status: %@", bean.status);
        NSLog (@"count: %d", bean.isLoved);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"error %@",[error localizedDescription]);
    }];
}

/**
 * @brief This method is used  for DID IT activities.
 */
- (void) postDidItAction
{
    NSString *postData = [NSString stringWithFormat:@"content_id=%@&description=%@&image_url=%@",@"2025952:Recipe:8080",@"Very Testy...",@""];
    [api connectWithServer:postData requestType:@"POST" api:YOKO_DIDIT_UPDATE parameters:nil success:^(NSDictionary *objects)
     {
         NSDictionary *obj = (NSDictionary*)[StatusJsonParser parseJSON:objects];
         BaseBean *bean = (BaseBean *)obj;
         NSLog (@"status: %@", bean.status);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@",[error localizedDescription]);
     }];
}

/**
 * @brief This method is used  for COLLECTION activities.
 */
- (void) postCollectionData
{
    NSString *postData = [NSString stringWithFormat:@"annotation=%@&collection_id=%@&collection_name=%@&content_id=%@",@"Nice one...",@"2025952:Collection:68700",@"",@"2025952:Recipe:7783"];
    [api connectWithServer:postData requestType:@"POST" api:YOKO_POST_COLLECTION parameters:nil success:^(NSDictionary *objects)
    {
        NSDictionary *obj = (NSDictionary *)[AddCollectionJsonParser parseJSON:objects];
        for (CollectionBean * collectionBean in obj)
        {
            NSLog (@"status %@", collectionBean.status);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"error %@",[error localizedDescription]);
    }];

}
/**
 * @brief This method is used  for COMMENT activities.
 */

- (void) postCommentData
{
    NSString *postData = [NSString stringWithFormat:@"comment=%@&objectId=%@",@"Testy dish...",@"2025952:ActivityEvent:68656"];
    [api connectWithServer:postData requestType:@"POST" api:YOKO_COMMENT_SAVE parameters:nil success:^(NSDictionary *objects)
     {
         NSDictionary *obj = (NSDictionary *)[CommentListJsonParser parseJSON:objects];         
         for (CommentBean * commentBean in obj)
         {
             NSLog (@"Comment:content: %@", commentBean.content);
         }
     }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@",[error localizedDescription]);
     }];
}

/**
 * @brief This method is used  for Follow user activities.
 */
- (void) followUser
{
    NSString *postData = [NSString stringWithFormat:@"followeeId=%@&followerId=%@",[YokoAPIUtils getValueFromNSUserDefaultWithKey:YOKO_LOGGEDINUSERID],@"2025952:Yuser:68343"];
    [api connectWithServer:postData requestType:@"POST" api:YOKO_FOLLOW_USER parameters:nil success:^(NSDictionary *objects)
     {
         NSDictionary *obj = (NSDictionary *)[StatusJsonParser parseJSON:objects];
         BaseBean *bean = (BaseBean *)obj;
         NSLog (@"status: %@", bean.status);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@",[error localizedDescription]);
     }];

}

/**
 * @brief This method is used  for unfollow user activities.
 */
- (void) unfollowUser
{
    NSString *postData = [NSString stringWithFormat:@"followeeId=%@&followerId=%@",[YokoAPIUtils getValueFromNSUserDefaultWithKey:YOKO_LOGGEDINUSERID],@"2025952:Yuser:68343"];
    [api connectWithServer:postData requestType:@"POST" api:YOKO_UNFOLLOW_USER parameters:nil success:^(NSDictionary *objects)
     {
         NSDictionary *obj = (NSDictionary *)[StatusJsonParser parseJSON:objects];
         BaseBean *bean = (BaseBean *)obj;
         NSLog (@"status: %@", bean.status);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@",[error localizedDescription]);
     }];

}
/**
 * @brief This method is used for get notification count of logged in user.
 */

-(void)getNotificationCount
{
    [api connectWithServer:nil requestType:@"GET" api:YOKO_NOTIFICATION_COUNT parameters:nil success:^(NSDictionary *objects)
     {
         NSString *notificationCount = [objects objectForKey:@"count"];
         NSLog(@"Count %@",notificationCount);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@",[error localizedDescription]);
     }];
}
/**
 * @brief This method is used for get notification details of logged in user.
 */
-(void)getNotificationDetail
{
    [api connectWithServer:nil requestType:@"GET" api:YOKO_All_NOTIFICATION parameters:nil success:^(NSDictionary *objects)
     {
         NSMutableArray *obj = [NotificationDetailJsonParser parseJSON:objects];
         NSLog(@"obj %@",obj);
     }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@",[error localizedDescription]);
     }];
}

/**
 * @brief This method is used for get following users restaurant activity time line data.
 */
- (void) getDiscover
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"Restaurant", @"type", @"following", @"filter", nil];    
    [api connectWithServer:nil requestType:@"GET" api:YOKO_DISCOVER parameters:params success:^(NSDictionary *objects)
     {
         NSDictionary *obj = (NSDictionary *)[DiscoverJsonParser parseJSON:objects];
         for (ActivityBean * activity in obj)
         {
            NSLog (@"activity: %@", activity.title);
         }
         
     }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"error %@",[error localizedDescription]);
    }];
         
}





///Commented by Devangi

/*
- (void) getNotification
{
    [api getNotificationCount: ^(NSObject * object)
     {
         NSLog (@"Notification Count: %@", object);
     }
                      failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
                          if(YOKO_DEBUG)
                          {
                              [UIComponents errorAlert:[error localizedDescription]];
                          }
     }
    ];

    [api getNotificationDetail: ^(NSObject * object)
     {
         NSLog (@"Notification Detail: %@", object);
     }
                       failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
                           if(YOKO_DEBUG)
                           {
                               [UIComponents errorAlert:[error localizedDescription]];
                           }
     }
    ];
}

- (void) postLoveAction
{
    [api postLoveData:@"2025952:Recipe:8080" action:@"love" param:nil success: ^(NSObject * object)
     {
         LoveBean *bean = (LoveBean *)object;
         NSLog (@"status: %@", bean.status);
         NSLog (@"count: %d", bean.isLoved);
         NSLog (@" Love objects %@",object);
     }
              failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
                  if(YOKO_DEBUG)
                  {
                      [UIComponents errorAlert:[error localizedDescription]];
                  }
     }
    ];
}

- (void) postDidItAction
{
    [api postDidItData:@"2025952:Recipe:8080" description:@"Very Testy..." imageURL:@"" param:nil success: ^(NSObject * object)
     {
         BaseBean *bean = (BaseBean *)object;
         NSLog (@"status: %@", bean.status);
     }
               failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
                   if(YOKO_DEBUG)
                   {
                       [UIComponents errorAlert:[error localizedDescription]];
                   }
     }
    ];
}

- (void) postCollectionData
{
    [api postCollectionData:@"Nice one..." collectionID:@"2025952:Collection:68700" collectionName:@"" contentID:@"2025952:Recipe:7783" param:nil success: ^(NSArray * objects)
     {
         for (CollectionBean * collectionBean in objects)
         {
             NSLog (@"status %@", collectionBean.status);
         }
     }
     failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
     }
    ];
}

- (void) postCommentData
{
    [api postCommentData:@"Testy dish..." objectID:@"2025952:ActivityEvent:68656" param:nil success: ^(NSArray * object)
     {
         for (CommentBean * commentBean in object)
         {
             NSLog (@"Comment:content: %@", commentBean.content);
         }
     }
     failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
     }
    ];
}

- (void) followUser
{
    NSString *loggedInAutherID; = [YokoAPIUtils getValueFromNSUserDefaultWithKey:YOKO_LOGGEDINUSERID];
    [api postFollow:loggedInAutherID followeeId:@"2025952:Yuser:68343" success: ^(NSObject * object)
     {
         BaseBean *bean = (BaseBean *)object;
         NSLog (@"status: %@", bean.status);
     }
            failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
                if(YOKO_DEBUG)
                {
                    [UIComponents errorAlert:[error localizedDescription]];
                }
     }
    ];
    }

- (void) unfollowUser
{
    NSString *loggedInAutherID; = [YokoAPIUtils getValueFromNSUserDefaultWithKey:YOKO_LOGGEDINUSERID];
    [api postUnFollow:loggedInAutherID followeeId:@"2025952:Yuser:68343" success: ^(NSObject * object)
     {
         BaseBean *bean = (BaseBean *)object;
         NSLog (@"status: %@", bean.status);
     }
              failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
                  if(YOKO_DEBUG)
                  {
                      [UIComponents errorAlert:[error localizedDescription]];
                  }
     }
    ];
}

- (void) getDiscover
{
    [api getDiscover:@"Restaurant" filter:@"following" success: ^(NSArray * objects)
     {
         for (ActivityBean * activity in objects)
         {
             NSLog (@"activity: %@", activity.title);
         }
     }
     failure: ^(AFHTTPRequestOperation * operation, NSError * error) {
         if(YOKO_DEBUG)
         {
             [UIComponents errorAlert:[error localizedDescription]];
         }
     }
    ];
}

 */
- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
