//
//  UserRequest.swift
//  axon_test
//
//  Created by Serhii PERKHUN on 12/5/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import Foundation
import Alamofire

class UserRequest {
    let url = "https://randomuser.me/api/?results=20"
    
    func makeRequest(completion: @escaping (Users?) -> Void) {
        request(url).validate().responseData { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    var result: Users?
                    
                    do {
                        result = try JSONDecoder().decode(Users.self, from: value)
                    }
                    catch let error {
                        print(error)
                    }
                    completion(result)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
