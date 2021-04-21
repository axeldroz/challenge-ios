//
//  BanksViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

protocol BanksViewModelDataProtocol {
    var parentBanks: [ParentBankCellViewModel] { get set }
    var banks: [[BankCellViewModel]] { get set }
}

protocol BanksViewModelProtocol: BanksViewModelDataProtocol {
    var onDataUpdated: (() -> Void)? { get set }
    
    init(service: BanksInfoServiceProtocol)
    func fetch()
}

class BanksViewModel: BanksViewModelProtocol {
    private let service: BanksInfoServiceProtocol
    
    var onDataUpdated: (() -> Void)?
    
    var parentBanks: [ParentBankCellViewModel] = []
    var banks: [[BankCellViewModel]] = []
    
    required init(service: BanksInfoServiceProtocol = BanksInfoService()) {
        self.service = service
    }
    
    func fetch() {
        let clientId = "dd6696c38b5148059ad9dedb408d6c84"
        let clientSecret = "56uolm946ktmLTqNMIvfMth4kdiHpiQ5Yo8lT4AFR0aLRZxkxQWaGhLDHXeda6DZ"
        
        service.fetchBanks(clientId: clientId, clientSecret: clientSecret, limit: 100) { [weak self] (result) in
            switch result {
            case .success(let response):
                response.resources.forEach { (res) in
                    res.parentBanks.forEach { (bankParent) in
                        print("bankParent: ", bankParent.name)
                    }
                }
                
                let parentBanksModels = response.resources.compactMap { $0 }.flatMap{ $0.parentBanks.compactMap { $0 } }.sorted { $0.name < $1.name }
                
                self?.parentBanks = parentBanksModels.compactMap { ParentBankCellViewModel(model: $0) }
                
                parentBanksModels.forEach({[weak self] (parentBank) in
                    var arr: [BankCellViewModel] = []
                    parentBank.banks.forEach { (bank) in
                        let vm = BankCellViewModel(model: bank)
                        arr.append(vm)
                    }
                    self?.banks.append(arr)
                })
                self?.onDataUpdated?()
            break
                
            case .failure(let error):
                print("error: " + error.localizedDescription)
            break
            }
        }
    }
}
