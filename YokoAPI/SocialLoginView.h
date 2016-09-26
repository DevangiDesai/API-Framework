//
//  SocialLoginView.h
//  YokoAPI
//
//  Created by Devangi on 27/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YokoFacebookLogin;
@class YokoSocialAPI;

@class SocialLoginView;
@protocol SocialLoginViewClassDelegate

-(void)createAuthenticationViewController;

@end

@interface SocialLoginView : UIView
{
    YokoFacebookLogin *yokoFacebookLogin;
    YokoSocialAPI *yokoSocialAPI;
}
@property (nonatomic, assign) id delegate;

/**
 * @brief This method is used for initialize social login view
 */
-(void)initWithSubView;

@end
