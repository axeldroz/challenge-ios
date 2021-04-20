//
//  FeedTableViewCell.swift
//  bankin-challenge-ios
//
//  Created by Axel Droz on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(viewModel: FeedCellViewModel) {
        textLabel?.text = viewModel.name
    }

}
