//
//  Coordinator.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childrenCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    func start()
    func goBanksPage()
    func logout()
}
