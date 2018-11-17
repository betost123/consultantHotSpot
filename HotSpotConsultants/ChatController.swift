//
//  ChatController
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-14.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UITableViewController {
    var cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "snowMountain"))
        
        let logOutButton = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.leftBarButtonItem = logOutButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        
        let chatButton = UIBarButtonItem(title: "chat", style: .plain, target: self, action: #selector(handleMessages))
        self.navigationItem.rightBarButtonItem = chatButton
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        
        
        //if user aint logged in then kick him out
        checkIfUserIsLoggedIn()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        observeMessages()
    }
    
    var messages = [Message]()
    var messageDictionary = [String : Message]()
    
    func observeMessages() {
        
        Database.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let message = Message()
                
                message.fromID = dictionary["fromID"] as? String
                message.text = (dictionary["text"] as? String?)!
                message.timestamp = dictionary["timestamp"] as? NSNumber
                message.toID = dictionary["toID"] as? String
 
                //only keep track of one message per recipient, so that we just display the latest message from each user in the table view
                if let toID = message.toID {
                    self.messageDictionary[toID] = message
                    
                    self.messages = Array(self.messageDictionary.values)
                    self.messages.sort(by: { (message1, message2) -> Bool in
                        return message1.timestamp!.intValue > message2.timestamp!.intValue
                    })
                }
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8556292808)
        let message = messages[indexPath.row]
        
        
        cell.message = message
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
    
    
    @objc func showChatControllerForUser(user: User) {
        let chatLogController = ChatLogCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //FIXME: set left nav item title to "Profile"
        chatLogController.user = user
        
        navigationController?.pushViewController(chatLogController, animated: true)
        
    }
    
    //top right bar button item
    @objc func handleMessages() {
        let chatsController = ChatsTableViewController()
        chatsController.contactThingy = self
        let navController = UINavigationController(rootViewController: chatsController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            //user isn't logged in
            perform(#selector(logOut), with: nil, afterDelay: 0) //present controller after it's loaded
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
    }
    
    @objc func logOut() {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    
}
