//
//  FeedCellViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

class BankCellViewModel {
    let name: String
    let logoUrl: String?
    
    init(model: BankModel) {
        self.name = model.name
        self.logoUrl = model.logoUrl
    }
}
