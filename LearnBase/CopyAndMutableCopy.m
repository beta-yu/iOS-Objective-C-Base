//
//  CopyAndMutableCopy.m
//  LearnBase
//
//  Created by qiyu on 2020/3/13.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "CopyAndMutableCopy.h"

@interface CopyAndMutableCopy ()

@property (nonatomic, copy) NSArray *arr1;
@property (nonatomic, copy) NSMutableArray *arr2;

@end

@implementation CopyAndMutableCopy

- (void)test3 {
    NSMutableArray *mutableArr = [NSMutableArray array];
    self.arr1 = mutableArr; // 如果NSArray在定义时使用strong修饰，调用set方法时不会产生深拷贝，则会出现以下情况, 因此应该使用copy修饰
    [mutableArr addObject:@"hello"];
    
    NSLog(@"%@", self.arr1);
//    2020-03-13 16:49:13.878240+0800 LearnBase[4620:37567082] (
//        hello
//    )
    
    self.arr2 = mutableArr; //如果NSMutableArray在定义时使用copy修饰，调用set方法会产生一个不可变的对象，因此会出现以下情况
    [self.arr2 addObject:@"world"]; // unrecognized selector sent to instance 0x1024002f0
    NSLog(@"%@", self.arr2);
    
    // 当然，容器间赋值时也不应该直接使用setter方法，而可以根据需要使用copy or mutableCopy
}


// 不可变容器
- (void)test {
    NSString *str = @"hello";
    NSArray *arr1 = [NSArray arrayWithObjects:str, nil];
    NSLog(@"%p--%p", arr1, arr1[0]);
    NSArray *arr2 = [arr1 copy];
    NSLog(@"%p--%p", arr2, arr2[0]); //不可变对象copy, 浅拷贝
    NSMutableArray *mutableArr3 = [arr1 mutableCopy];
    NSLog(@"%p--%p", mutableArr3, mutableArr3[0]); //不可变对象mutableCopy, 深拷贝(非完全拷贝，数组中元素的地址并没有改变，仅拷贝了数组本身)
    
//    2020-03-13 15:29:03.204397+0800 LearnBase[87886:37461358] 0x1007b96f0--0x100002060
//    2020-03-13 15:29:03.204912+0800 LearnBase[87886:37461358] 0x1007b96f0--0x100002060
//    2020-03-13 15:29:03.204976+0800 LearnBase[87886:37461358] 0x103200890--0x100002060
}

// 可变容器
- (void)test1 {
    NSString *str = @"hello";
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:str, nil];
    NSLog(@"%p--%p", arr1, arr1[0]);
    NSArray *arr2 = [arr1 copy]; // 深拷贝（非完全拷贝）
    NSLog(@"%p--%p", arr2, arr2[0]);
    NSMutableArray *arr3 = [arr1 mutableCopy]; // 深拷贝（非完全拷贝）
    NSLog(@"%p--%p", arr3, arr3[0]);
    
//    2020-03-13 15:34:31.302249+0800 LearnBase[89027:37468521] 0x10079dc60--0x100002060
//    2020-03-13 15:34:31.302811+0800 LearnBase[89027:37468521] 0x10078fa20--0x100002060
//    2020-03-13 15:34:31.302863+0800 LearnBase[89027:37468521] 0x10079e760--0x100002060
}

//拷贝数组中元素
- (void)test2 {
    NSMutableString *str = [NSMutableString stringWithFormat:@"hello"];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:str forKey:@"key1"];
    
    // 将字典存入数组
    NSMutableArray *arr1 = [NSMutableArray arrayWithObject:dict];
    
    // 用旧数组生成新数组
    NSMutableArray *arr2 = [NSMutableArray arrayWithArray:arr1]; // 深拷贝，数组内容指向没有变
    
    NSArray *arr3 = [arr1 copy]; // arr3中dict仍指向原dict
    
    // 使用copyItems拷贝数组元素
    NSMutableArray *arr4 = [[NSMutableArray alloc] initWithArray:arr1 copyItems:YES];
    // 一层深拷贝（比上面说的深拷贝多拷贝一层），拷贝了arr1中的dict, 但dict中的str仍与原来指向相同
    
    // 把数组归档为一个NSData，再解档，实现实现完全深拷贝
    NSData *data = [NSArchiver archivedDataWithRootObject:arr1];
    NSMutableArray *arr5 = [NSUnarchiver unarchiveObjectWithData:data];
    
    // 向字典中加入新值
    [dict setValue:@"jack" forKey:@"key2"];
    // 修改str
    [str appendString:@" world"];
    
    NSLog(@"%@", arr1);
    NSLog(@"%@", arr2);
    NSLog(@"%@", arr3);
    NSLog(@"%@", arr4);
    NSLog(@"%@", arr5);
    
    NSLog(@"%p--%p--%p", arr1, arr1[0], arr1[0][@"key1"]);
    NSLog(@"%p--%p--%p", arr2, arr2[0], arr2[0][@"key1"]);
    NSLog(@"%p--%p--%p", arr3, arr3[0], arr3[0][@"key1"]);
    NSLog(@"%p--%p--%p", arr4, arr4[0], arr4[0][@"key1"]);
    NSLog(@"%p--%p--%p", arr5, arr5[0], arr5[0][@"key1"]);
    
//    2020-03-13 16:36:08.740332+0800 LearnBase[1914:37550166] (
//            {
//            key1 = "hello world";
//            key2 = jack;
//        }
//    )
//    2020-03-13 16:36:08.740931+0800 LearnBase[1914:37550166] (
//            {
//            key1 = "hello world";
//            key2 = jack;
//        }
//    )
//    2020-03-13 16:36:08.741103+0800 LearnBase[1914:37550166] (
//            {
//            key1 = "hello world";
//            key2 = jack;
//        }
//    )
//    2020-03-13 16:36:08.741174+0800 LearnBase[1914:37550166] (
//            {
//            key1 = "hello world";
//        }
//    )
//    2020-03-13 16:36:08.741233+0800 LearnBase[1914:37550166] (
//            {
//            key1 = hello;
//        }
//    )
//    2020-03-13 16:36:08.741267+0800 LearnBase[1914:37550166] 0x1007772d0--0x1007770a0--0x100777070
//    2020-03-13 16:36:08.741300+0800 LearnBase[1914:37550166] 0x1007773c0--0x1007770a0--0x100777070
//    2020-03-13 16:36:08.741333+0800 LearnBase[1914:37550166] 0x100768e70--0x1007770a0--0x100777070
//    2020-03-13 16:36:08.741361+0800 LearnBase[1914:37550166] 0x1007775d0--0x1007775b0--0x100777070
//    2020-03-13 16:36:08.741387+0800 LearnBase[1914:37550166] 0x100775030--0x100774af0--0x100774550
}

@end
