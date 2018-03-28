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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"undefinedKey%@", key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    return @"1234";
}

@end

@interface Passenger : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *nationality;
@property (nonatomic, strong) NSString *phone;

@end

@implementation Passenger

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([@"id" isEqualToString:key] && [value isKindOfClass:[NSString class]]) {
        self.ID = value;
    }
    
    if([@"phoneNumber" isEqualToString:key] && [value isKindOfClass:[NSString class]]) {
        self.phone = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    if ([@"id" isEqualToString:key]) {
        return self.ID;
    }
    if([@"phoneNumber" isEqualToString:key]) {
        return self.phone;
    }
    return nil;
}

- (void)setNilValueForKey:(NSString *)key {
    if([@"age" isEqualToString:key]) {
        self.age = 100;
    }
    //nationality为NSString类型，赋值为nil不会执行该方法
    if([@"nationality" isEqualToString:key]) {
        self.nationality = @"中国";
    }
}

@end

void keyPath();
void dictionary();
void undefineKey();
void json2Model();

const NSString *json = @"{\"name\": \"lxz\",\"id\": \"4310222\", \"phoneNumber\": \"12345678900\"}";

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");

        keyPath();
        dictionary();
        undefineKey();
        json2Model();
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

void dictionary() {
    Object1 *obj3 = [Object1 new];
    Object1 *subObj = [Object1 new];
    subObj.str1 = @"bbb";
    
    [obj3 setValuesForKeysWithDictionary:@{@"str1":@"ccc", @"subObj":subObj}];
    NSDictionary *dic = [obj3 dictionaryWithValuesForKeys:@[@"str1", @"subObj"]];
    NSLog(@"%@", dic);
}

void undefineKey() {
    Object1 *obj = [Object1 new];
    obj.subObj = [Object1 new];
    [obj setValue:@"123" forKey:@"str2"];
    NSString *value = [obj valueForKey:@"str3"];
    NSLog(@"%@", value);
}

void json2Model() {
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    Passenger *passenger = [Passenger new];
    [passenger setValuesForKeysWithDictionary:dictionary];
    [passenger setValue:nil forKey:@"age"];
    [passenger setValue:nil forKey:@"nationality"];
    NSLog(@"age:%ld", (long)passenger.age);
    NSLog(@"ID:%@", passenger.ID);
    NSLog(@"nationality:%@", passenger.nationality);
    NSLog(@"phone:%@", passenger.phone);
}
