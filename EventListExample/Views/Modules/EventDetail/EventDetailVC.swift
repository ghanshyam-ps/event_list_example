//
//  EventDetailVC.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import UIKit

class EventDetailVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblDescription: UILabel?
    @IBOutlet weak var imgThumb: UIImageView?
    
    
    private let viewModel: EventDetailViewModel
    
    init?(viewModel: EventDetailViewModel, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:coder:)")
    }
    
    override func viewDidLoad() {
        
        self.navigationItem.title = "Event Details"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(EventDetailVC.onDismiss)
        )
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    private func configureUI() {
        lblName?.text = viewModel.name
        lblTitle?.text = viewModel.title
        lblDate?.text = viewModel.dateTime
        lblDescription?.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        imgThumb?.sd_setImage(
            with: URL(string: viewModel.imageURL!)
        )
        
    }
    
    @objc func onDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
