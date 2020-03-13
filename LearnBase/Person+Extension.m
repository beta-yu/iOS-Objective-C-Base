//
//  Person+Extension.m
//  LearnBase
//
//  Created by qiyu on 2020/3/8.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "Person+Extension.h"
#import <objc/runtime.h>

#import <AppKit/AppKit.h>


@implementation Person (Extension)

- (void)setAge:(NSInteger)age {
    objc_setAssociatedObject(self, "age", [NSNumber numberWithInteger:age], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)age {
    NSNumber *age = objc_getAssociatedObject(self, "age");
    return age.integerValue;
}

@end
