//
//  Person.m
//  FQAppThinDemo
//
//  Created by nebula on 2020/5/22.
//  Copyright © 2020 nebula. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)sayHi {
    NSLog(@"person say hi");
}

- (void)sayGoodbye {
    NSLog(@"person say goodbye");
}

+ (void)run {
    NSLog(@"class function: run");
}

+ (void)jump {
    NSLog(@"class function: jump");
}

@end
