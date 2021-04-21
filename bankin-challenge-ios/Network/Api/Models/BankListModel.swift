//
//  BankListModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

struct BankListModel: Decodable {
    let resources: [ResourceModel]
    let pagination: PaginationModel
}

struct ResourceModel: Decodable {
    let countryCode: String
    let parentBanks: [ParentBankModel]
}

struct ParentBankModel: Decodable {
    let name: String
    let logoUrl: String?
    let banks: [BankModel]
    let displayOrder: Int
}

struct BankModel: Decodable {
    let id: Int
    let resourceUri: String
    let resourceType: String
    let name: String
    let parentName: String?
    let countryCode: Country
    let automaticRefresh: Bool
    let primaryColor: String?
    let secondaryColor: String?
    let logoUrl: String?
    let deeplinkIos: String?
    let transferEnabled: Bool
    let paymentEnabled: Bool
}

struct PaginationModel: Decodable {
    let previousUri: String?
    let nextUri: String?
}

