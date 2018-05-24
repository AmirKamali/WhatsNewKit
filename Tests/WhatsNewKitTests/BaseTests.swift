//
//  BaseTests.swift
//  TveeeKit
//
//  Created by Sven Tiigi on 09.04.18.
//  Copyright © 2018 opwoco GmbH. All rights reserved.
//

import XCTest

class BaseTests: XCTestCase {
    
    /// The timeout value while waiting
    /// that an expectation is fulfilled
    lazy var expectationTimeout: TimeInterval = 10.0
    
    /// Random String
    lazy var randomString: String = self.generateRandomString()
    
    /// Random Data
    lazy var randomData: Data = self.generateRandomData()
    
    /// Random Int
    lazy var randomInt: Int = self.generateRandomInt()
    
    /// Random Double
    lazy var randomDouble: Double = self.generateRandomDouble()
    
    /// SetUp
    override func setUp() {
        super.setUp()
        // Disable continueAfterFailure
        self.continueAfterFailure = false
    }
    
    /// Perform test with expectation
    ///
    /// - Parameters:
    ///   - name: The expectation name
    ///   - timeout: The optional custom timeout
    ///   - execution: The test execution
    func performTest(name: String = #function,
                     timeout: TimeInterval? = nil,
                     execution: (XCTestExpectation) -> Void) {
        // Create expectation with function name
        let expectation = self.expectation(description: name)
        // Perform test execution with expectation
        execution(expectation)
        // Wait for expectation been fulfilled with custom or default timeout
        self.waitForExpectations(timeout: timeout.flatMap { $0 } ?? self.expectationTimeout, handler: nil)
    }
    
    /// Generate a random String
    ///
    /// - Returns: A random string
    func generateRandomString() -> String {
        return UUID().uuidString
    }
    
    /// Generate a random Int
    ///
    /// - Returns: A random Int
    func generateRandomInt() -> Int {
        return Int(arc4random_uniform(100))
    }
    
    /// Generate a random Double
    ///
    /// - Returns: A random Double
    func generateRandomDouble() -> Double {
        return Double(self.generateRandomInt())
    }
    
    /// Generate a random Data object
    ///
    /// - Returns: Random Data object
    func generateRandomData() -> Data {
        return Data(self.generateRandomString().utf8)
    }
    
}