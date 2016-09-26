//
//  TwitterLoginView.h
//  YokoAPI
//
//  Created by Devangi on 25/06/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YokoSocialAPI;

@class TwitterLoginView;

@protocol TwitterLoginViewClassDelegate

- (void)createEmailView;
- (void)createAuthenticationViewController;
@end

@interface TwitterLoginView : UIView<UITextFieldDelegate, UIActionSheetDelegate>
{
    YokoSocialAPI *yokoSocialAPI;
}

@property (nonatomic, assign) id emailDelegate;

/**
 * @brief This method is used for initialize twitter login view
 */
- (void)initwithSubView;

@end
