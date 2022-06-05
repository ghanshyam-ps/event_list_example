//
//  EventListCell.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 05/06/22.
//

import UIKit

class EventListCellViewModel {
    let name: String
    
    init(event: EventDataModel) {
        name = event.title
    }
}

class EventListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel?    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
