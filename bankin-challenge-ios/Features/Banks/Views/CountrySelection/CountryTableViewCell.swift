//
//  CountryTableViewCell.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(model: Country) {
        let imageName = ("ic_flag_" + model.rawValue).replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        imageView?.image = UIImage(named: imageName)
        textLabel?.text = model.rawValue.capitalized
    }

}
