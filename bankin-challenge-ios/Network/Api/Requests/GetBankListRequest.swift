//
//  GetBankListRequest.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation
import Alamofire // for HTTPMethod type

struct GetBankListRequest: ApiRequest {
    typealias Response = BankListModel
    typealias ErrorType = AFError
    
    var resourceName: String {
        return "banks"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    let client_id: String
    let client_secret: String
    let limit: Int
    
    init(clientId: String, clientSecret: String, limit: Int?) {
        client_id = clientId
        client_secret = clientSecret
        self.limit = limit ?? 20
    }
}
