//
//  ChatsTableViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-01.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class ChatsTableViewController: UITableViewController {
    
    //MARK: Vars
    var cellId = "cellId"
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Chats"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        
        fetchUser()

    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User()
                user.id = snapshot.key
                
                user.name = dictionary["name"] as? String
                user.mail = dictionary["mail"] as? String
                user.profileImageUrl = dictionary["profileImageUrl"] as? String
                self.users.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell

        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.mail
        

        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithURLString(urlString: profileImageUrl)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
    
    //FIXME: fixa contactthingname blavlabalbalbalablabalbalabla
    var contactThingy : ChatController?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            let user = self.users[indexPath.row]
            self.contactThingy?.showChatControllerForUser(user: user)
        }
    }
 
}


