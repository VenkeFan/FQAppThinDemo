//
//  ViewController.m
//  FQAppThinDemo
//
//  Created by nebula on 2020/5/22.
//  Copyright © 2020 nebula. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = [Person new];
    [p sayGoodbye];
    
    [Person run];
}


@end
