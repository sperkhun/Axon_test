//
//  ContactsViewController.swift
//  axon_test
//
//  Created by Serhii PERKHUN on 12/5/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    let request = UserRequest()
    var users: [Results] = []
    var isLoading = true
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        request.makeRequest() { users in
            if let users = users {
                self.users.append(contentsOf: users.results)
                self.tableView.reloadData()
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Uh oh, something has gone wrong. Please, try it later.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cansel", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            self.isLoading = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let cell = sender as? TableViewCell {
                let detail = segue.destination as! DetailViewController
                detail.user = cell.user
            }
        }
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! TableViewCell
        cell.user = self.users[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoading && (maximumOffset - contentOffset <= 100) {
            isLoading = true
            self.loadData()
        }
    }
}
