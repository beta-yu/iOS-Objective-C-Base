//
//  main.m
//  LearnBase
//
//  Created by qiyu on 2020/3/8.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base.h"
#import "CopyAndMutableCopy.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        Base *base = [Base new];
//        [base test];
        CopyAndMutableCopy *instance = [CopyAndMutableCopy new];
//        [instance test];
//        [instance test1];
//        [instance test2];
        [instance test3];
    }
    return 0;
}
