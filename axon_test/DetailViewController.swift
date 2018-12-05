//
//  DetailViewController.swift
//  axon_test
//
//  Created by Serhii PERKHUN on 12/5/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var user: Results?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userDob: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var eMail: UILabel!

    @IBOutlet weak var callButton: UIButton! {
        willSet {
            newValue.layer.cornerRadius = newValue.frame.size.height / 2
            newValue.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var userImage: UIImageView! {
        willSet {
            newValue.layer.cornerRadius = newValue.frame.size.width / 2
            newValue.clipsToBounds = true
        }
    }
    
    @IBAction func callButton(_ sender: UIButton) {
        if let url = URL(string: "tel://" + (user?.phone)!),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            }
            else {
                UIApplication.shared.openURL(url)
            }
        }
        else {
            showAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user != nil {
            writeData()
        }
        else {
            showAlert()
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Uh oh, something has gone wrong. Please, try it later.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cansel", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func writeData() {
        self.loadImage()
        self.userName.text = "\(user!.name.first) \(user!.name.last)"
        self.userGender.text = user!.gender
        self.phoneNumber.text = user!.phone
        self.eMail.text = user!.email
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd" // I think the format "YYYY-mm-dd" is wrong
        self.userDob.text = dateFormatter.string(from: user!.dob.date)
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
