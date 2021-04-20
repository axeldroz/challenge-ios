//
//  ApiClient.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

protocol ApiClient {
    func send<T: ApiRequest>(_ request: T,
                             completion: @escaping (Result<T.Response, T.ErrorType>) -> Void
    )
}
