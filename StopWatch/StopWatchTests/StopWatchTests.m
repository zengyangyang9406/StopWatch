//
//  StopWatchTests.m
//  StopWatchTests
//
//  Created by RNTD009 on 2017/4/28.
//  Copyright © 2017年 ZengYangYang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface StopWatchTests : XCTestCase
@property(nonatomic,strong)ViewController *vc;

@end

@implementation StopWatchTests

- (void)setUp {
    [super setUp];
    self.vc = [[ViewController alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.vc = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    int result = [self.vc getNum];
    XCTAssertEqual(result, 100,@"测试不通过");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
