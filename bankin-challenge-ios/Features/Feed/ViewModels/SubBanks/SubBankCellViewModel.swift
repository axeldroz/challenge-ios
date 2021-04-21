//
//  SubBankCellViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

class SubBankCellViewModel {
    let name: String
    let logoUrl: String?
    
    init(model: BankModel) {
        self.name = model.name
        self.logoUrl = model.logoUrl
    }
}
