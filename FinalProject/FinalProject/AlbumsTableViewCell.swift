//
//  AlbumsTableViewCell.swift
//  FinalProject
//
//  Created by Fred Luetkemeier on 5/9/19.
//  Copyright © 2019 Fred Luetkemeier. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtistNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
