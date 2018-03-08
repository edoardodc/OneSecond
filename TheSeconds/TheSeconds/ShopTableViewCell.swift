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
    @IBOutlet weak var buttonBuy: UIButton!
    static let identifier = "ShopTableViewCell"
    
    
    @IBAction func buttonTapped(_ sender: Any) {

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
}
