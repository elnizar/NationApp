//
//  CountryService.swift
//  NationsApp
//
//  Created by Nizar Elhraiech on 2019-01-25.
//  Copyright © 2019 Nizar. All rights reserved.
//

import Foundation
import Alamofire

class CountryService {
    
    func getCoutries(completion: @escaping (_ countries: [Country]?) -> Void)  {
        let url = "\(Constants.API_URL)/countries"
        
        let credentialData = "\(Constants.API_USER):\(Constants.API_PASS)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(url, method: .get, headers: headers)
            .responseData { response in
                do{
                    let json = response.data
                    let decoder = JSONDecoder()
                    let countries = try decoder.decode([Country].self, from: json!)
                    completion(countries)
                } catch let err {
                    print(err)
                    completion(nil)
                }
        }
    }
}
