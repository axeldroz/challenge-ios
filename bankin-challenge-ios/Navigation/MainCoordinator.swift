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
            goToFeed()
        }
    }
    
    func goToFeed() {
        let viewController = FeedViewController()
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
}
