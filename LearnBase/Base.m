//
//  Base.m
//  LearnBase
//
//  Created by qiyu on 2020/3/8.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "Base.h"
#import "Person.h"
#import "Person+Extension.h"

@interface Base ()

@property (nonatomic, strong) Person *person;

@end

@implementation Base

- (instancetype)init {
    self = [super init];
    if (self) {
        self.person = [Person new];
        [self.person addObserver:self
                      forKeyPath:@"name"
                         options:NSKeyValueObservingOptionPrior
                         context:@"hello"]; // 可通过context向KVO回掉方法传值
        // NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld 在回调方法中同时返回修改前与修改后的值(change)
        // NSKeyValueObservingOptionPrior 分别在值修改前后触发方法，一次修改会两次触发回调方法
        // NSKeyValueObservingOptionInitial 在注册观察者时会调用一次触发方法
    }
    return self;
}

- (void)test {
//    self.person.name = @"newName";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"noti" object:nil];
    // object参数：观察者想要接收其通知的对象； 也就是说，只有此发送者发送的通知才传递给观察者。
    // 如果您输入nil，则通知中心不会使用通知的发件人来决定是否将其发送给观察者。
    [Person postNotification];
    self.person.age = 20;
    NSLog(@"%ld", (long)self.person.age);
}

- (void)notification:(NSNotification *)notification {
    NSLog(@"name = %@, object = %@", notification.name, notification.object);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath-%@-object-%@-change-%@-context-%@", keyPath, object, change, context);
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"name"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
