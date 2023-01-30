//
//  HttpUtilityUnitTests.swift
//  AcronymTests
//
//  Created by Sonali on 27/01/23.
//

import XCTest
@testable import Acronym

class HttpUtilityUnitTests: XCTestCase {

    
    func test_getApiData_With_ValidRequest_Returns_Response(){
        
        let queryItems = [URLQueryItem(name: "sf", value: "nasa"), URLQueryItem(name: "If", value: nil)]
        var urlComps = URLComponents(string: Endpoints.getAcomine)!
        urlComps.queryItems = queryItems
        let reqUrl = urlComps.url!
        
        let httpUtility = HttpUtility()
        let expectation = self.expectation(description: "ValidRequest_Returns_Response")
        httpUtility.getApiData(requestUrl: reqUrl, resultType: [Acronym].self, completionHandler: {(acronymResponse) in
            XCTAssertNotNil(acronymResponse)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_getApiData_With_InValidRequest_Returns_Response(){
        
        let queryItems = [URLQueryItem(name: "sf", value: ""), URLQueryItem(name: "If", value: nil)]
        var urlComps = URLComponents(string: Endpoints.getAcomine)!
        urlComps.queryItems = queryItems
        let reqUrl = urlComps.url!
        let httpUtility = HttpUtility()
        let expectation = self.expectation(description: "ValidRequest_Returns_Response")
        httpUtility.getApiData(requestUrl: reqUrl, resultType: [Acronym].self, completionHandler: {(acronymResponse) in
            XCTAssertNotNil(acronymResponse)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
