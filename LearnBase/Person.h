//
//  Person.h
//  LearnBase
//
//  Created by qiyu on 2020/3/8.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;

+ (void)postNotification;

@end

NS_ASSUME_NONNULL_END
