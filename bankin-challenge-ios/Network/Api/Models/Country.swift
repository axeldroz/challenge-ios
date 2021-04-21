//
//  Country.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

//enum Country: String, Decodable {
//    case FR = "france"
//    case US = "united states"
//    case GB = "united kingdom"
//    case ES = "spain"
//    case DE = "germany"
//    case NL = "netherlands"
//}

enum Country: String, Decodable {
    case FR
    case US
    case GB
    case ES
    case DE
    case NL
    
    func toFullName() -> String {
        switch self {
        case .FR:
            return "france"
        case .US:
            return "united states"
        case .GB:
            return "united kingdom"
        case .ES:
            return "spain"
        case .DE:
            return "germany"
        case .NL:
            return "netherlands"
        }
    }
}
