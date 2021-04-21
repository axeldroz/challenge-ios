//
//  SwitchCountryButton.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

enum Country: String {
    case france
    case usa = "united states"
    case uk = "united kingdom"
    case spain
    case germany
    case netherlands
    case others = "others"
}

final class SwitchCountryButton: UIButton {
    
    var currentCountry: Country = .france {
        didSet {
            setTitle(self.currentCountry.rawValue.capitalized, for: .normal)
            let imageName = ("ic_flag_" + self.currentCountry.rawValue).replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
            setImage(UIImage(named: imageName), for: .normal)
        }
    }
    let borderLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layoutIfNeeded()
        setTitle(currentCountry.rawValue.capitalized, for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .clear
        //layer.cornerRadius = 12
        
        // bottom border
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        borderLayer.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(borderLayer)
        
        // images
        let leftImage = UIImage(named:"ic_flag_france")
        setImage(leftImage, for: .normal)
        contentHorizontalAlignment = .left
        //imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let borderWidth: CGFloat = 0.8
        let borderFrame = CGRect(x: 0.0, y: frame.size.height - borderWidth,
                                 width: frame.size.width, height: borderWidth)
        
        borderLayer.frame = borderFrame
    }
    
    private func drawBottomBorder() {
        
    }
}
