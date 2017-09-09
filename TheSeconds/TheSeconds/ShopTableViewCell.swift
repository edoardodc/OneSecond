//
//  ShopTableViewCell.swift
//  TheSeconds
//
//  Created by Owner on 19/08/17.
//  Copyright © 2017 Edoardo de Cal. All rights reserved.
//

import UIKit

class ShopTableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var saleRibbonImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPrize: UILabel!
    
    static let identifier = "ShopTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        saleRibbonImageView.alpha = 0

    }
}
