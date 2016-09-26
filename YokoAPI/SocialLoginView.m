//
//  SocialLoginView.m
//  YokoAPI
//
//  Created by Devangi on 27/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "SocialLoginView.h"
#import "TwitterLoginView.h"
#import "YokoSocialAPI.h"
#import "EmailLoginView.h"
#import "YokoAPIUtils.h"

@implementation SocialLoginView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }

    return self;
}

/**
 * @brief This method is used for initialize social login view 
 */
- (void) initWithSubView
{
    NSArray *buttonName = [NSArray arrayWithObjects:NSLocalizedString(@"FB_SignIn", nil),NSLocalizedString(@"Twitter_SignIn", nil),nil];
    [self createSocialLoginButton:buttonName];
}


/**
 * @brief This method is used for create social buttons(facebook and twitter)
  * @param buttonName is used to create the number of button and the set button name
 */
- (void) createSocialLoginButton:(NSArray *)buttonName
{
    CGFloat originY = self.frame.origin.y + 60;
    for (int i = 0; i < [buttonName count]; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(self.frame.origin.x + 80, originY, 150, 50);
        [button setTitle:[buttonName objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(signInButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        originY = originY + 80;
    }
}


/**
 * @brief This method is used for clik on social buttons(facebook and twitter)
 * @param sender is used for to get the button tag as per selection
 */
-(void) signInButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 0)
    {
        yokoSocialAPI = [YokoSocialAPI sharedInstance];
        yokoSocialAPI.delegate = self;
        [yokoSocialAPI initFacebookLogin];
    }
    else if (button.tag == 1)
    {
        TwitterLoginView *twitterLoginView = [[TwitterLoginView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 200, self.frame.size.width, self.frame.size.height)];
        twitterLoginView.emailDelegate = self;
        [twitterLoginView initwithSubView];
        [self addSubview:twitterLoginView];
    }    
}

/**
 * @brief This method is used to create emial login view.
 */
- (void) createEmailView
{
    [YokoAPIUtils removeSubViews:self];
    EmailLoginView *emailLoginView = [[EmailLoginView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 50, self.frame.size.width, self.frame.size.height)];
    [emailLoginView initWithSubView];
    [self addSubview:emailLoginView];
}

/**
 * @brief This method is used for navigate to the authentication view controlle using delegate method
 */
-(void)createAuthenticationViewController
{
    [_delegate createAuthenticationViewController];
  
    
}

@end
