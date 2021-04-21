//
//  ParentBankCellViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

class ParentBankCellViewModel {
    let name: String
    let logoUrl: String?
    let countryCode: Country
    
    init(model: ParentBankModel) {
        self.name = model.name
        self.logoUrl = model.logoUrl
        self.countryCode = model.banks.first?.countryCode ?? .FR
    }
}
