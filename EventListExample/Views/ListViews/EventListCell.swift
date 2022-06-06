//
//  EventListCell.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 05/06/22.
//

import UIKit
import AlamofireImage
import SDWebImage

class EventListCellViewModel {
    let id : String
    let name: String
    let title: String
    var imageView: UIImageView?
    var imageURL: String?
    let dateTime: String
    
    var onImageLoaded: (() -> ())? = nil
    
    init(event: EventDataModel) {
        id = event.id
        name = event.name
        title = event.title
        if(!event.datetime.isEmpty){
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from:event.datetime)!
            dateFormatter.dateFormat = "MMMM dd, yyyy - hh:mm a"
            dateTime = dateFormatter.string(from: date)
        } else {
            dateTime = ""
        }
        imageURL = event.image.isEmpty ? "https://picsum.photos/500" : event.image
        imageView?.sd_setImage(
            with: URL(string: imageURL!)
        )
    }
}

class EventListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel?    
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var imgThumb: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(event: EventListCellViewModel){
        lblTitle?.text = event.title
        lblDate?.text = event.dateTime
        lblName?.text = event.name
        imgThumb?.image = event.imageView?.image
        imgThumb?.sd_setImage(
            with: URL(string: event.imageURL!)
        )
    }
}
