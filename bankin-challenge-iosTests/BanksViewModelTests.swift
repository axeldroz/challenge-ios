//
//  BanksViewModelTests.swift
//  bankin-challenge-iosTests
//
//  Created by Axel Drozdzynski on 22/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import XCTest
@testable import bankin_challenge_ios

class BanksViewModelTests: XCTestCase {
    fileprivate var service: MockBanksService!
    var viewModel: BanksViewModel!
    
    override func setUp() {
        super.setUp()
        service = MockBanksService()
        viewModel = BanksViewModel(service: service)
    }
    
    override func tearDown() {
        service = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchBanks() {
        let modelData = BankListModel(resources: [],
                                      pagination: PaginationModel(previousUri: nil, nextUri: nil))
        service.data = modelData
        viewModel.fetch()
        
        XCTAssert(service!.isFetchBanksCalled)
    }
    
    func testFetchBanksWithData() {
        let subBank1 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameA", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let subBank2 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameB", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let parentBank1 = ParentBankModel(name: "name1", logoUrl: "logo1", banks: [subBank1, subBank2], displayOrder: 0)
        
        let subBank3 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameC", parentName: "name2", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let subBank4 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "named", parentName: "name2", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let parentBank2 = ParentBankModel(name: "name2", logoUrl: "logo2", banks: [subBank3, subBank4], displayOrder: 0)
        
        let resource1 = ResourceModel(countryCode: "FR", parentBanks: [parentBank1, parentBank2])
        let modelData = BankListModel(resources: [resource1],
                                      pagination: PaginationModel(previousUri: nil, nextUri: nil))
        service.data = modelData
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.allParentBanks.count, 2)
        XCTAssertEqual(viewModel.allSubBanks.count, 2)
        XCTAssertEqual(viewModel.parentBanks.count, 2)
        XCTAssertEqual(viewModel.subBanks.count, 2)
        
        XCTAssertEqual(viewModel.allSubBanks.flatMap{ $0 }.count, 4) // flatten array with all subBanks
        XCTAssertEqual(viewModel.subBanks.flatMap{ $0 }.count, 4) // flatten array with allFilteredBanls
    }
    
    func testFetchBanksWithDataDifferentCountry() {
        let subBank1 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameA", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let subBank2 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameB", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let parentBank1 = ParentBankModel(name: "name1", logoUrl: "logo1", banks: [subBank1, subBank2], displayOrder: 0)
        
        let subBank3 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameC", parentName: "name2", countryCode: .ES, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let subBank4 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "named", parentName: "name2", countryCode: .ES, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let parentBank2 = ParentBankModel(name: "name2", logoUrl: "logo2", banks: [subBank3, subBank4], displayOrder: 0)
        
        let resource1 = ResourceModel(countryCode: "FR", parentBanks: [parentBank1])
        let resource2 = ResourceModel(countryCode: "ES", parentBanks: [parentBank2])
        let modelData = BankListModel(resources: [resource1, resource2],
                                      pagination: PaginationModel(previousUri: nil, nextUri: nil))
        service.data = modelData
        viewModel.countryFilter = .ES
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.allParentBanks.count, 2)
        XCTAssertEqual(viewModel.allSubBanks.count, 2)
        XCTAssertEqual(viewModel.allSubBanks.flatMap{ $0 }.count, 4)
        
        XCTAssertEqual(viewModel.parentBanks.count, 1)
        XCTAssertEqual(viewModel.subBanks.count, 1)
        XCTAssertEqual(viewModel.subBanks.flatMap{ $0 }.count, 2)
        
        // we change country
        viewModel.countryFilter = .DE
        XCTAssertEqual(viewModel.parentBanks.count, 0)
        XCTAssertEqual(viewModel.subBanks.count, 0)
        XCTAssertEqual(viewModel.subBanks.flatMap{ $0 }.count, 0)
    }
    
    func testSubCellViewModel() {
        let subBank1 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameA", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let subBank2 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameB", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let parentBank1 = ParentBankModel(name: "name1", logoUrl: "logo1", banks: [subBank1, subBank2], displayOrder: 0)

        let resource1 = ResourceModel(countryCode: "FR", parentBanks: [parentBank1])
        let modelData = BankListModel(resources: [resource1],
                                      pagination: PaginationModel(previousUri: nil, nextUri: nil))
        service.data = modelData
        viewModel.fetch()

        XCTAssertNotNil(viewModel.allSubBanks.first)
        XCTAssertNotNil(viewModel.allSubBanks.first!.first)
        let cellViewModel = viewModel.allSubBanks.first!.first!
        XCTAssertEqual(cellViewModel.name, subBank1.name)
        XCTAssertEqual(cellViewModel.logoUrl, subBank1.logoUrl)
        XCTAssertEqual(cellViewModel.countryCode, subBank1.countryCode)
    }
    
    func testParentCellViewModel() {
        let subBank1 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameA", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let subBank2 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameB", parentName: "name1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let parentBank1 = ParentBankModel(name: "name1", logoUrl: "logo1", banks: [subBank1, subBank2], displayOrder: 0)
        
        let resource1 = ResourceModel(countryCode: "FR", parentBanks: [parentBank1])
        let modelData = BankListModel(resources: [resource1],
                                      pagination: PaginationModel(previousUri: nil, nextUri: nil))
        service.data = modelData
        viewModel.fetch()
        
        XCTAssertNotNil(viewModel.allParentBanks.first)
        let cellViewModel = viewModel.allParentBanks.first!
        XCTAssertEqual(cellViewModel.name, parentBank1.name)
        XCTAssertEqual(cellViewModel.logoUrl, parentBank1.logoUrl)
        XCTAssertEqual(cellViewModel.countryCode, .FR)
    }
    
    func testParentCellViewModelSorted() {
        let subBank1 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameA", parentName: "nameE1", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let subBank2 = BankModel(id: 0, resourceUri: "", resourceType: "", name: "nameB", parentName: "nameA2", countryCode: .FR, automaticRefresh: false, primaryColor: nil, secondaryColor: nil, logoUrl: "logourl", deeplinkIos: nil, transferEnabled: false, paymentEnabled: false)
        let parentBank1 = ParentBankModel(name: "nameE1", logoUrl: "logo1", banks: [subBank1], displayOrder: 0)
        let parentBank2 = ParentBankModel(name: "nameA2", logoUrl: "logo2", banks: [subBank2], displayOrder: 0)
        let resource1 = ResourceModel(countryCode: "FR", parentBanks: [parentBank1, parentBank2])
        let modelData = BankListModel(resources: [resource1],
                                      pagination: PaginationModel(previousUri: nil, nextUri: nil))
        service.data = modelData
        viewModel.fetch()
        
        XCTAssertNotNil(viewModel.allParentBanks.first)
        let cellViewModel = viewModel.allParentBanks.first!
        XCTAssertEqual(cellViewModel.name, parentBank2.name)
        XCTAssertEqual(cellViewModel.logoUrl, parentBank2.logoUrl)
        XCTAssertEqual(cellViewModel.countryCode, .FR)
    }
}

fileprivate class MockBanksService: BanksInfoServiceProtocol {
    var isFetchBanksCalled = false
    var data: BankListModel?
    
    func fetchBanks(clientId: String, clientSecret: String, limit: Int?, completion: @escaping (Result<GetBankListRequest.Response, GetBankListRequest.ErrorType>) -> Void) {
        isFetchBanksCalled = true
        if let data = data {
            completion(.success(data))
        }
    }
}
