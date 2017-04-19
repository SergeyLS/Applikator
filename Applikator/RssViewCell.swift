//
//  RssViewCell.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/12/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import UIKit

class RssViewCell: UITableViewCell {


    @IBOutlet weak var titleUI: UILabel!
    @IBOutlet weak var textUI: UILabel!
    @IBOutlet weak var dateUI: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textUI.adjustsFontSizeToFitWidth = false;
        textUI.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        backgroundColor = AppDataManager.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        titleUI.text = nil
        textUI.text = nil
        dateUI.text = nil
    }


}
