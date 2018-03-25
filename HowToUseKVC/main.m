//
//  main.m
//  HowToUseKVC
//
//  Created by zhichang.he on 2018/3/25.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Object1 :NSObject

@property (nonatomic, strong) NSString *str1;
@property (nonatomic, strong) Object1 *subObj;

@end

@implementation Object1

@end

void keyPath();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        //通用方法使用
//        Object1 *obj1 = [Object1 new];
//        [obj1 setValue:@"123" forKey:@"str1"];
//        NSString *str1 = [obj1 valueForKey:@"str1"];
//        NSLog(@"%@", str1);
//
//        //keyPath使用
//        obj1.obj2 = [Object1 new];
//        [obj1 setValue:@"456" forKeyPath:@"obj2.str1"];
//        id str2 = [obj1 valueForKeyPath:@"obj2.str1"];
//        if([str2 isKindOfClass:[NSString class]]) {
//            NSLog(@"%@", str2);
//        }
//
        keyPath();
        
        
    }
    return 0;
}

void keyPath() {
    //keyPath与数组
    NSMutableArray *array = [NSMutableArray array];
    Object1 *obj1 = [Object1 new];
    obj1.subObj = [Object1 new];
    
    Object1 *obj2 = [Object1 new];
    obj2.subObj = [Object1 new];
    
    [array addObject:obj1];
    [array addObject:obj2];
    [array setValue:@"789" forKey:@"str1"];
    [array setValue:@"aaa" forKeyPath:@"subObj.str1"];
    
    id strArray1 = [array valueForKey:@"str1"];
    //数组中所有对象的str1属性
    if([strArray1 isKindOfClass:[NSArray class]]) {
        for(NSString *item in strArray1) {
            NSLog(@"%@", item);
        }
    }
    
    id strArray2 = [array valueForKeyPath:@"subObj.str1"];
    if([strArray2 isKindOfClass:[NSArray class]]) {
        for(NSString *item in strArray2) {
            NSLog(@"%@", item);
        }
    }
}
