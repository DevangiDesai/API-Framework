//
//  UIComponents.m
//  YokoAPI
//
//  Created by Devangi on 08/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import "UIComponents.h"

@implementation UIComponents

+ (UIAlertView *) errorAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
    return alert;
}


+ (UIAlertView *) warningAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning!", nil)
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
    return alert;
}


@end
