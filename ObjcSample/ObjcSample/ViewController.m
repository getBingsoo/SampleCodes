//
//  ViewController.m
//  ObjcSample
//
//  Created by Lina Choi on 2020/12/01.
//  Copyright © 2020 anil. All rights reserved.
//

#import "ViewController.h"
#import "ObjcSample-Swift.h"
#import "ObjcSample-Bridging-Header.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    MyClass* f = [[MyClass alloc] init];
    [f introduce];
//    [f introduceBy: "aa" with: 1]
    MyClass2* ff = [[MyClass2 alloc] init];
//    [ff ]
    [ff class2];
    
}


@end
