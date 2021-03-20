//
//  main.m
//  PalringoPhotos
//
//  Created by Benjamin Briggs on 14/10/2016.
//  Copyright © 2016 Palringo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@import UIKit;
#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    Class appDelegateClass;
    @autoreleasepool {
        appDelegateClass = NSClassFromString(@"TestingAppDelegate");
        if (!appDelegateClass) {
            appDelegateClass = [AppDelegate class];
        }
    }
    return UIApplicationMain(argc, argv, nil,
                             NSStringFromClass(appDelegateClass));
}
