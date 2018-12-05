//
//  ViewController.swift
//  axon_test
//
//  Created by Serhii PERKHUN on 12/5/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let request = UserRequest()
    var users: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request.makeRequest() { users in
            if let users = users {
                self.users = users.results
            }
        }
    }
}

