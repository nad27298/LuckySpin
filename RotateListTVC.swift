//
//  RotateListTVC.swift
//  RotationLucky
//
//  Created by Macbook on 2/8/21.
//

import UIKit

class RotateListTVC: UITableViewCell {

    @IBOutlet weak var lblStt: UILabel!
    @IBOutlet weak var lblList: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblStt.layer.cornerRadius = lblStt.frame.height / 2
        lblStt.layer.masksToBounds = true
    }
    
}
