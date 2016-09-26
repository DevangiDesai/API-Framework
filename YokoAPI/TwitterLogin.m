//
//  TwitterLogin.m
//  YokoAPI
//
//  Created by Devangi on 24/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "TwitterLogin.h"
#import <Twitter/Twitter.h>

#define ConsumerKey @"JDZbnqyT5ZUl3pZGjPHYA"
#define ConsumerSecret @"1CWfFDbs7zysoa2w91z8D8TrBBmt8RTjHYnFWIcaw"



@implementation TwitterLogin


- (id)init
{
    if (self = [super init])
    {
    }
    return self;
}



-(void)loginWithTwitter
{
    NSLog(@"loginWithTwitter");
    // Is Twitter is accessible is there at least one account
    // setup on the device
    if ([TWTweetComposeViewController canSendTweet])
    {
        // Create account store, followed by a twitter account identifer
        account = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        // Request access from the user to use their Twitter accounts.
        [account requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error)
         {
             // Did user allow us access?
             if (granted == YES)
             {
                 // Populate array with all available Twitter accounts
                 arrayOfAccounts = [account accountsWithAccountType:accountType];
                 NSLog(@"self.arrayOfAccounts %@",arrayOfAccounts);
                                 
                 if ([arrayOfAccounts count] > 0)
                 {
                     [self performSelectorOnMainThread:@selector(getAccountInfo) withObject:NULL waitUntilDone:NO];
                 }
                
             }
            }];
        
    }
}

-(void)getAccountInfo
{
    [_delegate twitterInformation:arrayOfAccounts];
}

@end
