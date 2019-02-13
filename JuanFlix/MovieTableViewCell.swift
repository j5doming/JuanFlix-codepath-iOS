//
//  MovieTableViewCell.swift
//  JuanFlix
//
//  Created by Juan Dominguez on 2/12/19.
//  Copyright © 2019 Juan Dominguez. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
