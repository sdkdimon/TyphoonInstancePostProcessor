//
//  MainAssembly.m
//  InstancePostProcessor
//
//  Created by dimon on 17/01/2018.
//  Copyright © 2018 dimon. All rights reserved.
//

#import "MainAssembly.h"

#import "AppDelegate.h"
#import "ViewController.h"
#import "InstancePostProcessor.h"

@implementation MainAssembly

- (AppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(window) with:[self appWindow]];
    }];
}

- (UIWindow *)appWindow
{
    return [TyphoonDefinition withClass:[UIWindow class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(rootViewController) with:[self viewController]];
    }];
}

- (ViewController *)viewController
{
    return [TyphoonDefinition withClass:[ViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(instancePostProcessor) with:[self instancePostProcessor]];
    }];
}

- (InstancePostProcessor *)instancePostProcessor
{
    return [TyphoonDefinition withClass:[InstancePostProcessor class]];
}

@end
