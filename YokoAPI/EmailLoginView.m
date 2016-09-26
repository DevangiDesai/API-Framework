//
//  EmailLoginView.m
//  YokoAPI
//
//  Created by Devangi 03/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "EmailLoginView.h"
#import "YokoSocialAPI.h"

@implementation EmailLoginView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }

    return self;
}

/**
 * @brief This method is used for initialize email login view
 */
- (void) initWithSubView
{
    [self emailView];
}

/**
 * @brief This method is used for to call email text field and sign in button method
 */
- (void) emailView
{
    [self createEmailTextField];
    [self createSignInButton];
}


/**
 * @brief This method is used for to create sign in button.
 */
-(void)createSignInButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.frame.origin.x + 80, 150, 150, 50);
    [button setTitle:NSLocalizedString(@"SignIn", nil) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(signInButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}


/**
 * @brief This method is used for to create email text field.
 */
- (void) createEmailTextField
{
    CGFloat originY = self.frame.origin.y + 30;
    emailField = [[UITextField alloc] init];
    emailField.placeholder = NSLocalizedString(@"EnterEmail", nil);
    emailField.frame = CGRectMake(self.frame.origin.x + 40, originY, 230, 40);
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    emailField.leftView = paddingView;
    emailField.leftViewMode = UITextFieldViewModeAlways;
    [emailField setBackgroundColor:[UIColor whiteColor]];
    [emailField setTextColor:[UIColor blackColor]];
    emailField.returnKeyType = UIReturnKeyDone;
    emailField.delegate = self;
    emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:emailField];
}

/**
 * @brief This method is used for clik on social buttons(facebook and twitter)
 * @param sender is used for to get the button tag as per selection
 */
- (void) signInButtonClicked:(id)sender
{
    YokoSocialAPI *yokoSocialAPI = [YokoSocialAPI sharedInstance];

    [yokoSocialAPI finishYokoTwitterLoginWithEmail:emailField.text
                                           success:^(id responseObject)
     {
         NSLog(@"responseObject after supplying email: %@", responseObject);
     }
                                           failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", [error localizedDescription]);
     }];
}

#pragma mark text field delegates method

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.placeholder = nil;
}


- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        [textField setText:@""];
        textField.placeholder = NSLocalizedString(@"EnterEmail", nil);
    }
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSRange textFieldRange = NSMakeRange(0, [textField.text length]);
    if (NSEqualRanges(range, textFieldRange) && [string length] == 0)
    {
        // Game on: when you return YES from this, your field will be empty
    }
    else
    {
    }

    return YES;
}

@end
