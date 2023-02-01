//
//  HttpUtility.swift


import Foundation
import UIKit

protocol HttpUtilityProtocol {
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type,completionHandler:@escaping(_ result: T?)->Void)
}

struct HttpUtility: HttpUtilityProtocol
{
    // MARK :-   API call method 
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type,completionHandler:@escaping(_ result: T?)->Void) {
        
        
        URLSession.shared.dataTask(with: requestUrl){(responseData,httpUrlResponse,error) in
            
            if(error == nil && responseData != nil && responseData?.count != 0){
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completionHandler(result)
                }
                catch {
                        print(error.localizedDescription)
                    }
            }
        }.resume()
    }
    
    
}

 
