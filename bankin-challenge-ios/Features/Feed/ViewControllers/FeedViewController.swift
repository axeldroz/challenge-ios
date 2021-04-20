//
//  FeedViewController.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGOUT", for: .normal)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureUI()
    }
    
    private func configureUI() {
        configureButton()
    }
    
    private func configureButton() {
        view.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(_ sender: Any?) {
        coordinator?.logout()
    }
}
