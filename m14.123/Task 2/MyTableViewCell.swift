//
//  MyTableViewCell.swift
//  m14.123
//
//  Created by Ka4aH on 27.01.2023.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
