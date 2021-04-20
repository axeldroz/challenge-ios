//
//  ApiRequest.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation
import Alamofire // for HTTPMethod type

protocol ApiRequest: Encodable {
    associatedtype Response: Decodable
    associatedtype ErrorType: Error
    
    var resourceName: String { get }
    var method: HTTPMethod { get }
}

extension ApiRequest {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
