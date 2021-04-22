//
//  LoginViewController.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGIN", for: .normal)
        return button
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureUI()
    }
    
    private func configureUI() {
        configureBackgroundImageView()
        configureButton()
    }
    
    private func configureButton() {
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 25
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.8, height: 0.8)
        
        view.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureBackgroundImageView() {
        let image = UIImage(named: "intro_background")
        backgroundImageView.image = image
        view.addSubview(backgroundImageView)
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func buttonPressed(_ sender: Any?) {
        coordinator?.goBanksPage()
    }
}
