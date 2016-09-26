//
//  AuthenticationViewController.h
//  YokoAPI
//
//  Created by Devangi on 05/07/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YokoAPI.h"

@interface AuthenticationViewController : UIViewController
{
    /**
     * @brief This is used for call connet connectWithServer method  using shared instance.
     */
    YokoAPI *api;
    
}
@end
