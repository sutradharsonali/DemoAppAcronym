//
//  MockHttpUtility.swift
//  AcronymTests
//
//  Created by Sonali on 27/01/23.
//

import Foundation
@testable import Acronym
import XCTest

final class MockHttpUtility: HttpUtilityProtocol{
    var response : Data?
    
    
    func getApiData<T>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping (T?) -> Void) where T : Decodable {
        response = readLocalJSONFile(forName: "acronym")
        if let response = response{
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: response)
                completionHandler(result)
            }
            catch {
                    print("error: ", error.localizedDescription)
                }
        }
       
    }
    
    
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            guard let url = Bundle(for: MockHttpUtility.self).url(forResource: name, withExtension: "json")else { return nil}
        let data = try Data(contentsOf: url)
            return data
        
        }catch {
            print("error: \(error)")
        }
        return nil

    }
    
    
}
