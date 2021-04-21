//
//  BanksInfoService.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation
import Alamofire // for AFError

protocol BanksInfoServiceProtocol {
    func fetchBanks(clientId: String,
                    clientSecret: String,
                    limit: Int?,
                    completion: @escaping (Result<GetBankListRequest.Response, GetBankListRequest.ErrorType>) -> Void)
}

class BanksInfoService: BanksInfoServiceProtocol {
    func fetchBanks(clientId: String,
                    clientSecret: String,
                    limit: Int?,
                    completion: @escaping (Result<GetBankListRequest.Response, GetBankListRequest.ErrorType>) -> Void) {
        let request = GetBankListRequest(clientId: clientId, clientSecret: clientSecret, limit: 100)
        BankApiClient.shared.send(request, completion: completion)
    }
}
