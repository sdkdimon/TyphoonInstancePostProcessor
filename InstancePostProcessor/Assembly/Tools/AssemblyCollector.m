//
//  AssemblyCollector.m
//
//  Created by dimon on 11/08/16.
//  Copyright © 2016 @m5.+3rd4m. All rights reserved.
//

#import "AssemblyCollector.h"

#include "InitialAssembly.h"
#import <objc/runtime.h>

@implementation AssemblyCollector

- (NSArray *)collectInitialAssemblyClasses {
    NSMutableSet *resultClasses = [NSMutableSet set];
    
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class nextClass = classes[i];
            if ([self checkIfClassIsInitialAssembly:nextClass]) {
                [resultClasses addObject:nextClass];
            }
        }
        free(classes);
    }
    return [resultClasses allObjects];
}


- (BOOL)checkIfClassIsInitialAssembly:(Class)assemblyClass {
    if (assemblyClass == nil) {
        return NO;
    }
    
    if (class_conformsToProtocol(assemblyClass, @protocol(InitialAssembly))) {
        return YES;
    } else {
        return [self checkIfClassIsInitialAssembly:class_getSuperclass(assemblyClass)];
    }
}

@end
