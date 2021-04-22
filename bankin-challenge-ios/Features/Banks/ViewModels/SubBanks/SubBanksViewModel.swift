//
//  SubBanksViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

protocol SubBanksViewModelDataProtocol {
    var banks: [SubBankCellViewModel] { get set }
}

protocol SubBanksViewModelProtocol: SubBanksViewModelDataProtocol {
    init(banks: [SubBankCellViewModel])
}

class SubBanksViewModel: SubBanksViewModelProtocol {
    var banks: [SubBankCellViewModel]
    
    required init(banks: [SubBankCellViewModel]) {
        self.banks = banks
    }
}

