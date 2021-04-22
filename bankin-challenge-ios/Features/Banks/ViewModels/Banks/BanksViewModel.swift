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
    var subBanks: [[BankCellViewModel]] { get set }
    var countryFilter: Country { get set }
}

protocol BanksViewModelProtocol: BanksViewModelDataProtocol {
    var onDataUpdated: (() -> Void)? { get set }
    
    init(service: BanksInfoServiceProtocol)
    func fetch()
}

class BanksViewModel: BanksViewModelProtocol {
    private let service: BanksInfoServiceProtocol
    
    var onDataUpdated: (() -> Void)?
    
    private(set) var allParentBanks: [ParentBankCellViewModel] = []
    private(set) var allSubBanks: [[BankCellViewModel]] = []
    
    var parentBanks: [ParentBankCellViewModel] = []
    var subBanks: [[BankCellViewModel]] = []
    
    var countryFilter: Country = .FR {
        didSet {
            countryChanged()
        }
    }
    
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
                
                let parentBanksArr = parentBanksModels.compactMap { ParentBankCellViewModel(model: $0) }
                self?.allParentBanks = parentBanksArr
                self?.parentBanks = parentBanksArr.filter{[weak self] in $0.countryCode == self?.countryFilter }
                
                var subBanksArr: [[BankCellViewModel]] = []
                parentBanksModels.forEach({ (parentBank) in
                    var arr: [BankCellViewModel] = []
                    parentBank.banks.forEach { (bank) in
                        let vm = BankCellViewModel(model: bank)
                        arr.append(vm)
                    }
                    subBanksArr.append(arr)
                })
                self?.allSubBanks = subBanksArr
                self?.subBanks = subBanksArr.filter{[weak self] in $0.first?.countryCode ?? .FR == self?.countryFilter }
                self?.onDataUpdated?()
            break
                
            case .failure(let error):
                print("error: " + error.localizedDescription)
            break
            }
        }
    }
    
    private func countryChanged() {
        parentBanks = allParentBanks.filter{[weak self] in $0.countryCode == self?.countryFilter }
        subBanks = allSubBanks.filter{[weak self] in $0.first?.countryCode ?? .FR == self?.countryFilter }
        onDataUpdated?()
    }
}
