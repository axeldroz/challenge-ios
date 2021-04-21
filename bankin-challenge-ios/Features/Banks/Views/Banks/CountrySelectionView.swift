//
//  CountrySelectionView.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

final class CountrySelectionView: UIView {
    var heightConstraint: NSLayoutConstraint?
    
    var isShowing = false
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        //view.inse
        return view
    }()
    
    let franceButton = CountryButton(country: .france)
    let usButton = CountryButton(country: .us)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        franceButton.translatesAutoresizingMaskIntoConstraints = false
        usButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
       
        stackView.backgroundColor = .yellow
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       
        let button = UIButton()
        button.setTitle("TEST", for: .normal)
        
        stackView.addArrangedSubview(franceButton)
        stackView.addArrangedSubview(usButton)
        
//        franceButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        franceButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5).isActive = true
//        usButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        usButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func show() {
        
        heightConstraint?.constant = 150
        isShowing = true
        
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.superview?.layoutIfNeeded()
        }
    }
    
    func hide() {
        heightConstraint?.constant = 0
        isShowing = false
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.superview?.layoutIfNeeded()
        }
    }
}
