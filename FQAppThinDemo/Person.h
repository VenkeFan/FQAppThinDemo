//
//  Person.h
//  FQAppThinDemo
//
//  Created by nebula on 2020/5/22.
//  Copyright © 2020 nebula. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (void)sayHi;
- (void)sayGoodbye;

+ (void)run;
+ (void)jump;

@end

NS_ASSUME_NONNULL_END
