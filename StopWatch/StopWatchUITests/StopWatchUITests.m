//
//  StopWatchUITests.m
//  StopWatchUITests
//
//  Created by RNTD009 on 2017/4/28.
//  Copyright © 2017年 ZengYangYang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface StopWatchUITests : XCTestCase
@property(nonatomic,strong)ViewController *vc;
@end

@implementation StopWatchUITests

- (void)setUp {
    [super setUp];
    self.vc = [[ViewController alloc]init];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    self.vc = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testExample {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *button = app.buttons[@"\u8ba1\u6b21"];
    [app.buttons[@"\u6e05\u96f6"] tap];
    [[[XCUIApplication alloc] init].buttons[@"\u505c\u6b62"] tap];
    
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
