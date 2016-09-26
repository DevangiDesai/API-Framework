//
//  TwitterLoginView.m
//  YokoAPI
//
//  Created by Devangi on 25/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "TwitterLoginView.h"
#import "YokoSocialAPI.h"
#import "EmailLoginView.h"

@implementation TwitterLoginView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }

    return self;
}

/**
 * @brief This method is used for initialize twitter login view
 */
- (void) initwithSubView
{
    yokoSocialAPI = [YokoSocialAPI sharedInstance];
    yokoSocialAPI.delegate = self;
    [yokoSocialAPI loginWithTwitter];
}

/**
 * @brief This method is used for get list of account name and details
 * @param twitterAccounts is used for list of accounts

 */
- (void) getTwiiterAccountList:(NSArray *)twitterAccounts;
{
    [self showTwitterAccountInActionSheet:twitterAccounts];
}

/**
 * @brief This method is used for showing the twitter accounts from the system (iPhone device).and showing in the action sheet
 * @param twitterAccounts is used for list of accounts

 */
- (void) showTwitterAccountInActionSheet:(NSArray *)twitterAccounts
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choose An Account", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;

    for (ACAccount *acct in twitterAccounts)
    {
        [sheet addButtonWithTitle:acct.username];
    }

    [sheet showInView:self];
}


#pragma mark - UIActionSheetDelegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex != 0 )
    {
        [yokoSocialAPI loginToYokoWithTwitterAccount:(buttonIndex - 1) success: ^(id responseObject)
         {
             NSLog (@"responseObject: %@", responseObject);
             [self createAuthenticationViewController];
         }
                                 needsAdditionalInfo: ^(NSArray * infoNeeded)
         {
             NSLog (@"infoNeeded: %@", infoNeeded);
             [self createEmailView];
         }
         failure: ^(AFHTTPRequestOperation * operation, NSError * error)
         {
             NSLog (@"error: %@", [error localizedDescription]);
         }
        ];
    }
}
/**
 * @brief This method is used for to create email login view
 */
- (void) createEmailView
{
    [_emailDelegate createEmailView];
}

/**
 * @brief This method is used for navigate to the authentication view controlle using delegate method
 */
- (void) createAuthenticationViewController
{
    [_emailDelegate createAuthenticationViewController];
}


@end
