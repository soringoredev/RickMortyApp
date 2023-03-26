//
//  CharacterTableViewCell.swift
//  RickMorty
//
//  Created by Sorin Gore on 26.03.2023.
//

import UIKit
import CLTypingLabel

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myTypeWriterLabel: CLTypingLabel!
    
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var lastKnownLocationLabel: UILabel!
    
    @IBOutlet weak var firstSeenInLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
}
