//
//  UIBarButtonItem+MSExtension.m
//  MIS
//
//  Created by LIUZHEN on 2016/12/28.
//  Copyright © 2016年 58. All rights reserved.
//

#import "UIBarButtonItem+ZQExtension.h"
#import "UIControl+ZQExtension.h"
#import "UIColor+ZQExtension.h"
#import "NSString+ZQExtension.h"
#import "UIFont+ZQExtension.h"

@implementation UIBarButtonItem (ZQExtension)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action {
    return [self itemWithTitle:title
                     imageName:nil
                 highImageName:nil
                        target:target
                        action:action];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                        titleColor:(UIColor *)color
                            target:(id)target
                            action:(SEL)action {
    UIBarButtonItem *item = [self itemWithTitle:title
                                     titleColor:color
                                      imageName:nil
                                  highImageName:nil
                                         target:target
                                         action:action];
    return item;
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                        titleColor:(UIColor *)color
                 disableTitleColor:(UIColor *)disableTitleColor
                            target:(id)target
                            action:(SEL)action {
    return [self itemWithTitle:title titleColor:color disableTitleColor:disableTitleColor imageName:nil highImageName:nil target:target action:action];
}

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                target:(id)target
                                action:(SEL)action {
    return [self itemWithTitle:nil
                     imageName:imageName
                 highImageName:highImageName
                        target:target
                        action:action];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                         imageName:(NSString *)imageName
                     highImageName:(NSString *)highImageName
                            target:(id)target
                            action:(SEL)action {
    return [self itemWithTitle:title
                    titleColor:nil
                     imageName:imageName
                 highImageName:highImageName
                        target:target
                        action:action];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                        titleColor:(UIColor *)color
                         imageName:(NSString *)imageName
                     highImageName:(NSString *)highImageName
                            target:(id)target
                            action:(SEL)action {
    return [self itemWithTitle:title titleColor:color disableTitleColor:nil imageName:imageName highImageName:highImageName target:target action:action];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                        titleColor:(UIColor *)color
                 disableTitleColor:(UIColor *)disableTitleColor
                         imageName:(NSString *)imageName
                     highImageName:(NSString *)highImageName
                            target:(id)target
                            action:(SEL)action {
    color = color ?: [UIColor ms_colorWithHexString:@"#333333"];
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIButton *button = [[UIButton alloc] init];
    button.tintColor = color;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [button setTitleColor:color forState:UIControlStateNormal];
    if (disableTitleColor && [disableTitleColor isKindOfClass:UIColor.class]) {
        [button setTitleColor:disableTitleColor forState:UIControlStateDisabled];
        [button setTitleColor:disableTitleColor forState:UIControlStateDisabled | UIControlStateSelected];
    }
    if ([NSString isNotBlank:title] && [NSString isNotBlank:imageName]) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    [button sizeToFit];
    if (button.bounds.size.width < 30) {
        button.frame = CGRectMake(0, 0, 30, 30);
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                        titleColor:(UIColor *)color
                             image:(UIImage *)image
                         highImage:(UIImage *)highImage
                            target:(id)target
                            action:(SEL)action {
    color = color ?: [UIColor ms_colorWithHexString:@"#333333"];
    UIImage *image1 = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIButton *button = [[UIButton alloc] init];
    button.tintColor = color;
    [button setImage:image1 forState:UIControlStateNormal];
    [button setImage:image1 forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [button setTitleColor:color forState:UIControlStateNormal];

    if ([NSString isNotBlank:title] && image1) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    [button sizeToFit];
    if (button.bounds.size.width < 30) {
        button.frame = CGRectMake(0, 0, 30, 30);
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemFixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
