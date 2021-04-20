//
//  FeedCellViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

class FeedCellViewModel {
    let name: String
    
    init(model: BankModel) {
        self.name = model.name
    }
}
