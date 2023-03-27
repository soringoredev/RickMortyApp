//
//  CharactersTableViewCell.swift
//  RickMorty
//
//  Created by Sorin Gore on 27.03.2023.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    
   // @IBOutlet weak var myTypeWriterLabel: CLTypingLabel!
    
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lastKnownLocationLabel: UILabel!
    
    @IBOutlet weak var firstSeenInLabel: UILabel!
       
        
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
