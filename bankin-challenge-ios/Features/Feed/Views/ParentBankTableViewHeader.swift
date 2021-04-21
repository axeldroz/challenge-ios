//
//  ParentBankTableViewHeader.swift
//  bankin-challenge-ios
//
//  Created by Axel Droz on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

class ParentBankTableViewHeader: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
        nameLabel.numberOfLines = 2
        //nameLabel.textColor = .systemRed
        logoImageView.backgroundColor = .clear
        logoImageView.contentMode = .scaleAspectFit
    }
    
    func configureConstraints() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        
        logoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
