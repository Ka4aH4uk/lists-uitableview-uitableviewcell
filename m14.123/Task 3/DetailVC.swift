//
//  DetailViewController.swift
//  m14.123
//
//  Created by Ka4aH on 30.01.2023.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var detailInfo: NewsWithLocationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = "☞ \((detailInfo?.description)!) ©"
        locationLabel.text = "📍\((detailInfo?.location)!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
