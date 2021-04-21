//
//  ParentBankCollectionViewCell.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

class ParentBankCollectionViewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        logoImageView.image = nil
    }
    
    func setData(viewModel: ParentBankCellViewModel) {
        nameLabel.text = viewModel.name
        if let logoUrl = viewModel.logoUrl,
           let url = URL(string: logoUrl) {
            logoImageView.sd_setImage(with: url, completed: nil)
        } else {
            logoImageView.image = UIImage(named: "bank_default_image")
        }
    }
    
    func configureUI() {
        contentView.backgroundColor = .yellow
        nameLabel.numberOfLines = 2
        nameLabel.backgroundColor = .clear
        nameLabel.textAlignment = .center
        logoImageView.backgroundColor = .clear
        logoImageView.contentMode = .scaleAspectFit
        contentView.layer.cornerRadius = 12
    }
    
    func configureConstraints() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        
        logoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        //nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
}
