//
//  TableViewCell.swift
//  axon_test
//
//  Created by Serhii PERKHUN on 12/5/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var phoneNumber: UILabel!

    @IBOutlet weak var userImage: UIImageView! {
        willSet {
            newValue.layer.cornerRadius = newValue.frame.size.width / 2
            newValue.clipsToBounds = true
        }
    }

    var user: Results? {
        didSet {
            if user != nil {
                self.loadImage()
                self.userName.text = "\(user!.name.first) \(user!.name.last)"
                self.phoneNumber.text = user?.phone
            }
        }
    }
    
    func loadImage() {
        let url = URL(string: user!.picture.large)
        let qos = DispatchQoS.background.qosClass
        let queue = DispatchQueue.global(qos: qos)
        queue.async {
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.userImage.image = image
                    }
                }
            }
        }
    }

}
