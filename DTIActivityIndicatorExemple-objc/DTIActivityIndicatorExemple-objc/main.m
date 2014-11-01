//
//  main.m
//  DTIActivityIndicatorExemple-objc
//
//  Created by David Tisserand on 01/11/2014.
//  Copyright (c) 2014 dtissera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <DTIActivityIndicator/DTIActivityIndicator-Swift.h>

int main(int argc, char * argv[]) {
    [DTIActivityIndicatorView class];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
