//
//  AcronymViewModel.swift



import Foundation

struct AcronymTableViewCellViewModel {
    let lf : String
}

class AcronymViewModel {
    
    var acronyms: Observable<[AcronymTableViewCellViewModel]> = Observable([])
    var client : HttpUtilityProtocol? = nil
    

    
    func getAcronymRecords(searchValue : String)
    {
        let queryItems = [URLQueryItem(name: "sf", value: searchValue), URLQueryItem(name: "If", value: nil)]
        var urlComps = URLComponents(string: Endpoints.getAcomine)!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
            client?.getApiData(requestUrl: result, resultType: [Acronym].self, completionHandler: {[weak self](acronymResponse) in
                if let acronymResponse = acronymResponse {
                    if acronymResponse.isEmpty {
                        self?.acronyms.value = nil
                    }else{
                        for acronym in acronymResponse {
                            self?.acronyms.value = acronym.lfs.compactMap({
                                AcronymTableViewCellViewModel(lf: $0.lf )
                            })
                          
                        }
                    }
                    
                }
            })
       
    }
}


