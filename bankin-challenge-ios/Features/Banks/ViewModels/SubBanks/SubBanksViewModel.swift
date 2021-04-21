//
//  SubBanksViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

protocol SubBanksViewModelDataProtocol {
    var banks: [BankCellViewModel] { get set }
}

protocol SubBanksViewModelProtocol: SubBanksViewModelDataProtocol {
    init(banks: [BankCellViewModel])
}

class SubBanksViewModel: SubBanksViewModelProtocol {
    var banks: [BankCellViewModel]
    
    required init(banks: [BankCellViewModel]) {
        self.banks = banks
    }
}

