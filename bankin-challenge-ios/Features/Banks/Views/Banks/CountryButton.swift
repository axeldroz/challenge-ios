//
//  CountryButton.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

final class CountryButton: UIButton {
    enum Country: String {
        case france
        case us
    }
    
    var country: Country = .france
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    init(frame: CGRect, country: Country) {
        self.country = country
        super.init(frame: frame)
    }
    
    init(country: Country) {
        self.country = country
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layoutIfNeeded()
        setTitle(country.rawValue.capitalized, for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .clear
        //layer.cornerRadius = 12
        
        // bottom border
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        
        // images
        let leftImage = UIImage(named:"ic_flag_france")
        setImage(leftImage, for: .normal)
        contentHorizontalAlignment = .left
        //imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func drawBottomBorder() {
        
    }
}
