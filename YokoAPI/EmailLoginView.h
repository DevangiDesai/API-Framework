//
//  EmailLoginView.h
//  YokoAPI
//
//  Created by Devangi 03/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailLoginView : UIView<UITextFieldDelegate>
{
    UITextField *emailField;
}

/**
 * @brief This method is used for initialize email login view
 */
- (void)initWithSubView;

@end
