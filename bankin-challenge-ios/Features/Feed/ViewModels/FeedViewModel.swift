//
//  FeedViewModel.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import Foundation

protocol FeedViewModelDataProtocol {
    var banks: [FeedCellViewModel] { get set }
}

protocol FeedViewModelProtocol: FeedViewModelDataProtocol {
    var onDataUpdated: (() -> Void)? { get set }
    
    init(service: BanksInfoServiceProtocol)
    func fetch()
}

class FeedViewModel: FeedViewModelProtocol {
    private let service: BanksInfoServiceProtocol
    
    var onDataUpdated: (() -> Void)?
    var banks: [FeedCellViewModel] = []
    
    required init(service: BanksInfoServiceProtocol = BanksInfoService()) {
        self.service = service
    }
    
    func fetch() {
        let clientId = "dd6696c38b5148059ad9dedb408d6c84"
        let clientSecret = "56uolm946ktmLTqNMIvfMth4kdiHpiQ5Yo8lT4AFR0aLRZxkxQWaGhLDHXeda6DZ"
        
        service.fetchBanks(clientId: clientId, clientSecret: clientSecret, limit: nil) { [weak self] (result) in
            switch result {
            case .success(let response):
                response.resources.forEach { (res) in
                    res.parentBanks.forEach { (bankParent) in
                        print("bankParent: ", bankParent.name)
                    }
                }
                self?.banks = response.resources
                                .flatMap { $0.parentBanks.flatMap { $0.banks } }
                                .compactMap({ (bankModel) -> FeedCellViewModel in
                                    FeedCellViewModel(model: bankModel)
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
