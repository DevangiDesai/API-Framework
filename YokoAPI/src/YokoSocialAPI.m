//
//  YokoSocialAPI.m
//  YokoAPI
//
//  Created by Devangi on 28/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//
//  Test

#import "YokoSocialAPI.h"
#import "TWAPIManager.h"
#import <FacebookSDK/FacebookSDK.h>
#import "YokoAFNetAPIManager.h"
#import "API.h"
#import "YokoAPIUtils.h"
#import "YokoAPI.h"
#import "UserBean.h"
#import "MMConstant.h"
#import "UIComponents.h"

NSString *const FBSessionStateChangedNotification = @"com.facebook.samples.PublishFeedHowTo:FBSessionStateChangedNotification";

@implementation YokoSocialAPI

+ (id) sharedInstance
{
    static dispatch_once_t pred;
    static YokoSocialAPI *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[YokoSocialAPI alloc] init];
    }


                  );
    return sharedInstance;
}


- (id) init
{
    self = [super init];
    if (self)
    {
        self.didLogoutBlock = nil;
    }

    return self;
}


/**
 * @brief This method is for login with twitter.
 */
- (void) loginWithTwitter
{
    [self obtainAccessToAccountsWithBlock: ^(BOOL granted)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
                if (granted)
                {
                    if (![_arrayOfAccounts count])
                    {
                        [UIComponents errorAlert:NSLocalizedString(@"twitterErrorMessage", nil)];
                    }
                    else
                    {
                        [self getTwitterAcountList];
                    }
                }
                else
                {
                    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
                    {
                        [UIComponents warningAlert:NSLocalizedString(@"twitterWarningMessage", nil)];
                    }
                    else
                    {
                        [UIComponents errorAlert:NSLocalizedString(@"twitterGenericMessage", nil)];
                    }
                }
            }


                       );
    }


    ];
}


- (void) obtainAccessToAccountsWithBlock:( void ( ^)(BOOL) )block
{
    accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterType = [accountStore
                                  accountTypeWithAccountTypeIdentifier:
                                  ACAccountTypeIdentifierTwitter];
    NSString *reqSysVer = @"6.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
    {
        ACAccountStoreRequestAccessCompletionHandler handler =
            ^(BOOL granted, NSError *error) {
            if (granted)
            {
                self.arrayOfAccounts = [accountStore accountsWithAccountType:twitterType];
            }

            block(granted);
        };

        [accountStore requestAccessToAccountsWithType:twitterType
                                              options:nil
                                           completion:handler];
    }
    else
    {
        [accountStore requestAccessToAccountsWithType:twitterType withCompletionHandler: ^(BOOL granted, NSError *error)
        {
            if (granted)
            {
                self.arrayOfAccounts = [accountStore accountsWithAccountType:twitterType];
            }

            block(granted);
        }


        ];
    }
}


- (void) getTwitterAcountList
{
    [_delegate getTwitterAccountList:_arrayOfAccounts];
}


/**
 * @brief This method is for setting the selected account of twitter from settings while login and sharing.
 *
 * @param accountIndex Integer value of selected account
 * @param success A block object to be executed when the request operation finishes successfully. This block has no return value
   and takes two arguments: the created request operation and the object created from the response data of request.
 * @param needsInfoBlock A block object to be executed when the request operation needs extra execution.
 * @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes
   successfully, but encountered an error while parsing the response data. This block has no return value and takes two
   arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void) loginToYokoWithTwitterAccount:(NSInteger)accountIndex
                               success:( void ( ^)(id responseObject) )successBlock
                   needsAdditionalInfo:( void ( ^)(NSArray *infoNeeded) )needsInfoBlock
                               failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error, NSString *customErrorMsg) )failureBlock
{
    TWAPIManager *apiManager = [[TWAPIManager alloc] init];
    [apiManager performReverseAuthForAccount:_arrayOfAccounts[accountIndex] withHandler: ^(NSData *responseData, NSError *error)
    {
        if (responseData)
        {
            NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSArray *parts = [responseStr componentsSeparatedByString:@"&"];
            NSString *twitterResponseString = nil;
            if (parts.count >= 3)
            {
                twitterResponseString = [[[[[parts objectAtIndex:2] stringByAppendingString:@"&"] stringByAppendingString:[parts objectAtIndex:0]] stringByAppendingString:@"&"] stringByAppendingString:[parts objectAtIndex:1]];
            }
            else
            {
                //GSM-3503 - handling the error scenario when user revokes application's access from twitter and tries to Sign in.          On the basis of error code recieved in the response i.e 89, which is for unathorised/invalid token; an alert message is shown with custom message.

                NSRange textRange = [responseStr rangeOfString:@"code=\"89\""];
                if ( textRange.location != NSNotFound )
                {
                    failureBlock( nil, error, NSLocalizedString(@"errorInAuth", nil) );
                }
                else
                {
                    failureBlock( nil, error, NSLocalizedString(@"connectionFailed", nil) );
                }

                return;
            }

            [self yokoTwitterLogin:twitterResponseString success: ^(id responseObject)
                {
                    successBlock(responseObject);
                }


               needsAdditionalInfo: ^(NSArray *infoNeeded)
                {
                    needsInfoBlock(infoNeeded);
                }


             failure: ^(AFHTTPRequestOperation *operation, NSError *error)
                {
                    [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
                    failureBlock( operation, error, NSLocalizedString(@"connectionFailed", nil) );
                }


            ];
        }
        else
        {
            failureBlock( nil, error, NSLocalizedString(@"connectionFailed", nil) );
        }
    }


    ];
}


/**
 * @brief This method is for setting the selected account of twitter from settings while login and sharing.
 *
 * @param emailAddress Email Address String
 * @param success A block object to be executed when the request operation finishes successfully. This block has no return value
   and takes two arguments: the created request operation and the object created from the response data of request.
 * @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes
   successfully, but encountered an error while parsing the response data. This block has no return value and takes two
   arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void) finishYokoTwitterLoginWithEmail:(NSString *)emailAddress
                                 success:( void ( ^)(id responseObject) )successBlock
                                 failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    NSString *param = [NSString stringWithFormat:@"emailAddress=%@",emailAddress];
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    //when we set header here from our plist, aka user default, the second time login server will send back 404 error, hence we set as nil
    //all the follwing methods apply the same
    AFHTTPRequestOperation *opr = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:param headerParam:nil parameters:nil path:YOKO_SOCIAL_SIGNUP forFeedType:EJSON];
    signUpFlag = FALSE;

    [opr setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        AFHTTPRequestOperation *opr;
        opr = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:nil path:YOKO_SOCIAL_SIGNIN forFeedType:EJSON];
        if ([responseObject objectForKey:@"error"])
        {
            NSDictionary *error = [responseObject objectForKey:@"error"];
            if ([error objectForKey:@"existingUser"] || [error objectForKey:@"emailAddress"])
            {
                successBlock(responseObject);
                return;
            }
        }

        [opr setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
            {
                [YokoAPIUtils setCookies];
                successBlock(responseObject);
            }


                                   failure: ^(AFHTTPRequestOperation *operation, NSError *error)
            {
                failureBlock(operation, error);
            }


        ];
        [opr start];

        successBlock(responseObject);
    }


                               failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [opr start];
}


/**
 * @brief This method is for setting the selected account of twitter from settings while login and sharing.
 *
 * @param twitterResponseString Response from twitter api
 * @param success A block object to be executed when the request operation finishes successfully. This block has no return value
   and takes two arguments: the created request operation and the object created from the response data of request.
 * @param needsInfoBlock A block object to be executed when the request operation needs extra execution.
 * @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes
   successfully, but encountered an error while parsing the response data. This block has no return value and takes two
   arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void) yokoTwitterLogin:(NSString *)twitterResponseString
                  success:( void ( ^)(id responseObject) )successBlock
      needsAdditionalInfo:( void ( ^)(NSArray *infoNeeded) )needsInfoBlock
                  failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:twitterResponseString headerParam:nil parameters:nil path:YOKO_TWITTER_SIGNIN forFeedType:99]; // 99 is a hack to accept all content-type.

    [requestOperation setRedirectResponseBlock: ^NSURLRequest * (NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse)
    {
        NSString *cookieValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"xg_ep"];
        self.loginService = @"Twitter";
        if (!cookieValue)
        {
            [YokoAPIUtils setCookies];
            signUpFlag = FALSE;
            self.loginType = kYokoLoginTypeSignIn;
        }

        NSString *requestString = [YokoAPIUtils urlRequestToString:request];
        if ([requestString rangeOfString:@"auth/socialSignUp"].location != NSNotFound)
        {
            signUpFlag = TRUE;
            self.loginType = kYokoLoginTypeSignUp;
        }

        return request;
    }


    ];
    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (signUpFlag)
        {
            // switch into sign up flow.
            NSMutableArray *infoNeeded = [NSMutableArray array];
            [infoNeeded addObject:@"email_address"];
            needsInfoBlock(infoNeeded);
        }
        else
        {
            // signing in, not signing up.
            AFHTTPRequestOperation *opr = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:nil path:YOKO_SOCIAL_SIGNIN forFeedType:EJSON];
            [opr setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
                {
                    [YokoAPIUtils setCookies];
                    if (![YokoAPIUtils hasYokoCookie])
                    {
                        failureBlock(operation, nil);
                    }
                    else
                    {
                        successBlock(responseObject);
                    }
                }


                                       failure: ^(AFHTTPRequestOperation *operation, NSError *error)
                {
                    failureBlock(operation, error);
                }


            ];
            [opr start];
        }
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        // This is called on getting internal server errors and timeouts.
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/**
 * @brief This method is for login with facebook.
 */
- (void) initFacebookLogin
{
    // Remove previous notification before adding.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FBSessionStateChangedNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateChanged:) name:FBSessionStateChangedNotification object:nil];

    [self loginWithFacebook];
}


/**
 * @brief This method is for login with facebook.
 */
- (void) loginWithFacebook
{
    if (FBSession.activeSession.isOpen)
    {
        //NOTE: Why are we closing session here?
        [self closeSession];
    }
    else
    {
        [self openSessionWithAllowLoginUI:YES];
    }
}


/*
 * @brief  Configure the logged in versus logged out UI
 *
 * @param  notification provide notification
 */
- (void) sessionStateChanged:(NSNotification *)notification
{
    if (FBSession.activeSession.isOpen)
    {
        // Call "me" graph api to make sure access token is valid.
        [FBRequestConnection startForMeWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error)
            {
                NSString *fbAccessToken = [[[FBSession activeSession] accessTokenData] accessToken];

                // Clear signUpFlag. This flag is used in this process.
                signUpFlag = NO;
                [self yokoFacebookLogin:fbAccessToken success: ^(id responseObject)
                    {
                        // Don't run loginCompleted here when signUpFlag is enabled. loginCompleted should be called after sign up process.
                        if (!signUpFlag)
                        {
                            [self loginCompleted:responseObject];
                            [self closeSession];
                        }
                    }


                    needsAdditionalInfo: ^(NSArray *infoNeeded)
                    {
                        NSLog(@"infoNeeded: %@", infoNeeded);
                        [self loginToFacebook];
                    }


                 failure: ^(AFHTTPRequestOperation *operation, NSError *error)
                    {
                        NSLog(@"error: %@", [error localizedDescription]);
                        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];

                        // We require to close Facebook session on error. Cannot login if session has been opened on retrying.
                        if (FBSession.activeSession.isOpen)
                        {
                            [self closeSession];
                        }

                        [self loginFail];
                    }


                ];
            }
            else
            {
                // An error occurred, we need to handle the error
                // See: https://developers.facebook.com/docs/ios/errors
                NSLog(@"facebook error %@", error);

                [self openSessionWithAllowLoginUI:YES];
            }
        }


        ];
    }
    else
    {
        //[self.authButton setTitle:@"Login" forState:UIControlStateNormal];
        //NSLog(@"Reauth actions");
    }
}


/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL) openSessionWithAllowLoginUI:(BOOL)allowLoginUI
{
    NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
    return [FBSession openActiveSessionWithReadPermissions:permissions
                                              allowLoginUI:allowLoginUI
                                         completionHandler: ^(FBSession *session,FBSessionState state,NSError *error)
    {
        [self sessionStateChanged:session state:state error:error];
    }


    ];
}


/*
 * Callback for session changes.
 */
- (void) sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    switch (state)
    {
        case FBSessionStateOpen:
            if (!error)
            {
                NSLog(@"User session found");
            }

            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:session];

    if (error)
    {
        [self loginFail];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", nil)
                                                        message:NSLocalizedString(@"facebookLoginFail", nil)
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


/*
 * Close Session of Facebook..
 */
- (void) closeSession
{
    [FBSession.activeSession closeAndClearTokenInformation];
}


/**
 * @brief This method is for setting the selected account of twitter from settings while login and sharing.
 *
 * @param facebookAccessToken Access Token from Facebook login
 * @param success A block object to be executed when the request operation finishes successfully. This block has no return value
   and takes two arguments: the created request operation and the object created from the response data of request.
 * @param needsInfoBlock A block object to be executed when the request operation needs extra execution.
 * @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes
   successfully, but encountered an error while parsing the response data. This block has no return value and takes two
   arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void) yokoFacebookLogin:(NSString *)facebookAccessToken
                   success:( void ( ^)(id responseObject) )successBlock
       needsAdditionalInfo:( void ( ^)(NSArray *infoNeeded) )needsInfoBlock
                   failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    NSString *param = [NSString stringWithFormat:@"access_token=%@",facebookAccessToken];
    AFHTTPRequestOperation *requestOperation = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:param headerParam:nil parameters:nil path:YOKO_FACEBOOK_SIGNIN forFeedType:99]; // 99 is a hack to accept all content-type.

    // Yoko Facebook signin API will redirect to
    [requestOperation setRedirectResponseBlock: ^NSURLRequest * (NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse)
    {
        NSString *cookieValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"xg_ep"];
        self.loginService = @"Facebook";
        if (!cookieValue)
        {
            [YokoAPIUtils setCookies];
            signUpFlag = FALSE;
            self.loginType = kYokoLoginTypeSignIn;
        }

        NSString *requestString = [YokoAPIUtils urlRequestToString:request];
        if ([requestString rangeOfString:@"auth/socialSignUp"].location != NSNotFound)
        {
            // This will be processed in parallel. Should be moved into complete block.
            signUpFlag = TRUE;
            self.loginType = kYokoLoginTypeSignUp;
        }

        return request;
    }


    ];

    [requestOperation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (signUpFlag)
        {
            // Signing Up.
            NSMutableArray *infoNeeded = [NSMutableArray array];
            [infoNeeded addObject:@"email_address"];
            needsInfoBlock(infoNeeded);
        }
        else
        {
            // signing in, not signing up.
            AFHTTPRequestOperation *opr = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"GET" dataToPost:nil headerParam:nil parameters:nil path:YOKO_SOCIAL_SIGNIN forFeedType:EJSON];
            [opr setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
                {
                    [YokoAPIUtils setCookies];
                    if (![YokoAPIUtils hasYokoCookie])
                    {
                        failureBlock(operation, nil);
                    }
                    else
                    {
                        successBlock(responseObject);
                    }
                }


                                       failure: ^(AFHTTPRequestOperation *operation, NSError *error)
                {
                    [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
                    failureBlock(operation, error);
                }


            ];

            [opr start];
        }
    }


                                            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        // This will be called when getting internal server errors and timeouts.
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [requestOperation start];
}


/*
 * @brief Login to facebook.
 */
- (void) loginToFacebook
{
    [self finishYokoFacebookLogin: ^(id responseObject)
    {
        [self loginCompleted:responseObject];
        [self closeSession];
    }


                          failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
    }


    ];
}


- (void) loginFail
{
    // Clean intermediate authorization related data on failure.
    [self logout];

    if (_delegate && [_delegate respondsToSelector:@selector(loginFail)])
    {
        [_delegate loginFail];
    }
}


- (void) loginCompleted:(id)responseObj
{
    if (_delegate && [_delegate respondsToSelector:@selector(loginCompleted:)])
    {
        [_delegate loginCompleted:responseObj];
    }
}


/**
 * @brief This method is for setting the selected account of twitter from settings while login and sharing.
 * @note Looks caller does not exist.
 * @param success A block object to be executed when the request operation finishes successfully. This block has no return value
   and takes two arguments: the created request operation and the object created from the response data of request.
 * @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes
   successfully, but encountered an error while parsing the response data. This block has no return value and takes two
   arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void) finishYokoFacebookLogin:( void ( ^)(id responseObject) )successBlock
                         failure:( void ( ^)(AFHTTPRequestOperation *operation, NSError *error) )failureBlock
{
    YokoAFNetAPIManager *manager = [YokoAFNetAPIManager sharedInstance];
    AFHTTPRequestOperation *opr = [manager hitRequest:[YokoAPI baseURL] delegate:self requestType:@"POST" dataToPost:nil headerParam:nil parameters:nil path:YOKO_SOCIAL_SIGNUP forFeedType:EJSON];
    signUpFlag = FALSE;

    [opr setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        successBlock(responseObject);
    }


                               failure: ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [YokoAPIUtils logAPIErrorWithOperation:operation andError:error];
        failureBlock(operation, error);
    }


    ];

    [opr start];
}


- (void) logout
{
    [YokoAPIUtils clearCookies];
    [YokoAPIUtils resetDefaults];
    [FBSession.activeSession closeAndClearTokenInformation];

    if (self.didLogoutBlock)
    {
        self.didLogoutBlock();
    }
}


@end
