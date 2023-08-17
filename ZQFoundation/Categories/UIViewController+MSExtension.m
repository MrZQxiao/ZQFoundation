//
//  UIViewController+MSExtension.m
//  MIS
//
//  Created by LIUZHEN on 2017/2/14.
//  Copyright © 2017年 58. All rights reserved.
//

#import "UIViewController+MSExtension.h"
#import "NSString+MSExtension.h"
#import "UIColor+MSExtension.h"
#import "UIImage+MSExtension.h"
#import "UIFont+MSExtension.h"
#import "UIBarButtonItem+MSExtension.h"
#import <objc/runtime.h>
#import "NSObject+MSExtension.h"
#import "MSRouter.h"

@implementation UIViewController (MSExtension)

#pragma mark - Public Methods

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(initWithNibName:bundle:)),
                                   class_getInstanceMethod([self class], @selector(ms_initWithNibName:bundle:)));
}

- (instancetype)ms_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    UIViewController *vc = [self ms_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    return vc;
}

+ (UIWindow *)frontWindow {
#if !defined(SV_APP_EXTENSIONS)
    __block UIWindow *fwindow;
    void(^block)(void) = ^(){
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows) {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
            if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
                fwindow = window;
            }
        }
    };
    if (NSThread.isMainThread) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
#endif
    return fwindow;
}

+ (__kindof UIViewController * )currentViewController {
    __block UIViewController *viewController;
    [self performSelectorOnMainThreadWithSync:^{
        viewController = [self ms_findViewController:self.frontWindow.rootViewController];
    }];
    return viewController;
}

+ (UIViewController *)ms_findViewController:(UIViewController *)viewController {
    if (viewController.presentedViewController) {
        return [self ms_findViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *vc = (UISplitViewController *)viewController;
        if (vc.viewControllers.count > 0) {
            return [self ms_findViewController:vc.viewControllers.lastObject];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *vc = (UINavigationController *)viewController;
        if (vc.viewControllers.count > 0) {
            return [self ms_findViewController:vc.topViewController];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *vc = (UITabBarController *)viewController;
        if (vc.viewControllers.count > 0) {
            return [self ms_findViewController:vc.selectedViewController];
        } else {
            return viewController;
        }
//    } else if ([viewController isKindOfClass:[MSCTabBarController class]]) {
//        MSCTabBarController *vc = (MSCTabBarController *)viewController;
//        if (vc.viewControllers.count > 0) {
//            return [self ms_findViewController:vc.selectedViewController];
//        } else {
//            return viewController;
//        }
    } else if ([viewController isKindOfClass:NSClassFromString(@"MSTabBarController")]) {
        UIViewController *vc = viewController;
        return [self ms_findViewController:[MSRouter performTarget:@"tabBar" action:@"currentVC" params:nil]];
    } else {
        return viewController;
    }
}

- (void)setupOrientation:(UIInterfaceOrientation)orientation {
    id <UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:NSSelectorFromString(@"setOrientation:")]) {
        [(id)delegate setValue:@(orientation) forKey:@"orientation"];
        [self setupDeviceOrientation:orientation];
    }
}

- (void)resetRotation {
    [self setupOrientation:UIInterfaceOrientationPortrait];
}

- (void)setupDeviceOrientation:(UIInterfaceOrientation)orientation {
    NSNumber *orientationNumber = [NSNumber numberWithInteger:orientation];
    [UIDevice.currentDevice setValue:orientationNumber forKey:@"orientation"];
    //强制旋转
    [UIViewController attemptRotationToDeviceOrientation];
}

@end

