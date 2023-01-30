//
//  AcronymViewModelUnitTests.swift
//  AcronymTests
//
//  Created by Sonali on 27/01/23.
//

import XCTest
@testable import Acronym


class AcronymViewModelUnitTests: XCTestCase {

    var myViewModel = AcronymViewModel()
    var mockHttpUtility: MockHttpUtility!
    
    override func setUp() {
        mockHttpUtility = MockHttpUtility()
        myViewModel.client = mockHttpUtility
    }
    
    
    func test_getAcronymRecords_With_ValidRequest_Returns_Response(){
        myViewModel.getAcronymRecords(searchValue: "nasa")
    }
    
    

}
