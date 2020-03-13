//
//  Person.m
//  LearnBase
//
//  Created by qiyu on 2020/3/8.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "Person.h"

@implementation Person

// 如果key对应的属性被其他对象观察，若返回NO，则不会触发KVO对应的回调方法
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

+ (void)postNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:@"hello"];
}

@end
