//
//  MainCoordinator.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childrenCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let isLogged = false
        
        if (!isLogged) {
            let viewController = LoginViewController()
            viewController.coordinator = self
            navigationController.pushViewController(viewController, animated: false)
        } else {
            goBanksPage()
        }
    }
    
    func goBanksPage() {
        let viewController = BanksViewController()
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    func logout() {
        if (!(navigationController.topViewController is LoginViewController)) {
            let viewController = LoginViewController()
            viewController.coordinator = self
            navigationController.viewControllers = [viewController]
        }
    }
    
    func showSubBanks(subBanks: [BankCellViewModel]) {
        guard navigationController.topViewController is BanksViewController else { return }
        let viewModel = SubBanksViewModel(banks: subBanks)
        let subBankViewController = SubBanksViewController(viewModel: viewModel)
        let nc = UINavigationController(rootViewController: subBankViewController)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func showCountrySelectionPopup() {
        guard let parentVC = navigationController.topViewController as? BanksViewController else { return }
        let viewController = CountrySelectionPopupViewController()
//        viewController.modalPresentationCapturesStatusBarAppearance
        viewController.parentVC = parentVC
        viewController.modalPresentationStyle = .overCurrentContext
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
