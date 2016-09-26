//
//  TwitterLogin.h
//  YokoAPI
//
//  Created by Devangi on 24/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

// define the protocol for the delegate
@class TwitterLogin;
@protocol TwitterLoginDelegate

// define protocol functions that can be used in any class using this delegate
-(void)twitterInformation:(NSArray *)twitterLogininfo;

@end

@interface TwitterLogin : NSObject
{
     ACAccountStore  *account;
     NSArray *arrayOfAccounts;
    
}
// define delegate property
@property (nonatomic, assign) id  delegate;
/**
 * @brief This array is used for storing the twitter accounts and access those accounts.
 */
@property (nonatomic, assign) NSArray *accounts;
@property (nonatomic, strong) ACAccountStore *accountStore;


-(void)loginWithTwitter;



@end
