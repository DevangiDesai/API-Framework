//
//  UIComponents.h
//  YokoAPI
//
//  Created by Devangi on 08/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @brief This class contains information that returns all UICompenents.
 */
@interface UIComponents : NSObject

/**
 * @brief  This method is for showing alert
 *
 * @param  message to show in alert
 *
 * @return returns alertview
 */
+ (UIAlertView *)errorAlert:(NSString *)message;
+ (UIAlertView *)warningAlert:(NSString *)message;

@end
