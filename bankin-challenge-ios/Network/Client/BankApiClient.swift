//
//  BankApiClient.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation
import Alamofire

final class BankApiClient: ApiClient {
    static let shared = BankApiClient()
    let serverUrl = "https://sync.bankin.com" + "/v2/"
    let token = ""
    
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, T.ErrorType>) -> Void) where T: ApiRequest {
        let endpoint = "\(serverUrl)\(request.resourceName)"
        
        let headers: HTTPHeaders = [
            "Bankin-Version": "2018-06-15"
        ]
        
        let encoding: ParameterEncoding = (request.method == .get) ? URLEncoding(destination: .queryString) : JSONEncoding.default
        
        let params : ([String: Any])? = request.dictionary as ([String: Any])?
        
        AF.request(endpoint, method: request.method, parameters: params, encoding: encoding, headers: headers)
                .validate()
                .responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode(T.Response.self, from: data)
                            completion(.success(result) )
                        } catch let errorResponse {
                            print("error: \(errorResponse.localizedDescription)")
                            completion(.failure(AFError.ResponseValidationFailureReason.missingContentType as! T.ErrorType))
                        }
                    break
                        
                    case .failure(let errorResponse):
                        completion(.failure(errorResponse as! T.ErrorType))
                    break
                    }}
    }
    
    
}
