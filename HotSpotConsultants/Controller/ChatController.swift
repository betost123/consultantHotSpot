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
    //MARK: Properties
    var cellId = "cellId"
    var timer : Timer?
    var messages = [Message]()
    var messageDictionary = [String : Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set background image
        let backgroundImageView = UIImageView(image: UIImage(named: "snowMountain"))
        backgroundImageView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImageView
        
        //Navigation bar items
        let logOutButton = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logOut))
        //can be added with image and title, see saved page in web folder
        self.navigationItem.setLeftBarButton(logOutButton, animated: true)
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        let chatButton = UIBarButtonItem(title: "new", style: .plain, target: self, action: #selector(handleMessages))
        self.navigationItem.rightBarButtonItem = chatButton
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        
        //Tab Bar items
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        
        //if user aint logged in then kick him out
        checkIfUserIsLoggedIn()
        
        //register cells
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)

        //load table with messages
        observeUserMessages()
    }
    
    func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            let userID = snapshot.key
            Database.database().reference().child("user-messages").child(uid).child(userID).observe(.childAdded, with: { (snapshot) in
                let messageID = snapshot.key
                self.fetchMessageWithMessageID(messageID: messageID)
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    private func fetchMessageWithMessageID(messageID : String) {
        let messageRef = Database.database().reference().child("messages").child(messageID)
        messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let message = Message()
                
                message.fromID = dictionary["fromID"] as? String
                message.text = (dictionary["text"] as? String?)!
                message.timestamp = dictionary["timestamp"] as? NSNumber
                message.toID = dictionary["toID"] as? String
                
                //only keep track of one message per recipient, so that we just display the latest message from each user in the table view
                if let chatPartnerID = message.chatPartnerID() {
                    self.messageDictionary[chatPartnerID] = message
                }
                //Prevent having to reload data every time we observe a new message, now reload once / second
                self.attemptReloadOfTable()
            }
        }, withCancel: nil)
    }
    
    @objc func handleReloadTable() {
        self.messages = Array(self.messageDictionary.values)
        self.messages.sort(by: { (message1, message2) -> Bool in
            return message1.timestamp!.intValue > message2.timestamp!.intValue
        })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    private func attemptReloadOfTable() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }

    //MARK: Table view data
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        guard let chatPartnerID = message.chatPartnerID() else {
            return
        }
        
        let ref = Database.database().reference().child("users").child(chatPartnerID)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
                return
            }
            let user = User()
            user.id = chatPartnerID
            user.mail = dictionary["mail"] as? String
            user.name = dictionary["name"] as? String
            user.profileImageUrl = dictionary["profileImageUrl"] as? String
            
            self.showChatControllerForUser(user: user)
        }, withCancel: nil)
    }
    
    //MARK: Navigation bar items
    @objc func showChatControllerForUser(user: User) {
        let chatLogController = ChatLogCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
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
    @objc func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let loginController = LoginViewController()
        loginController.chatController = self
        present(loginController, animated: true, completion: nil)
    }
    
    //MARK: Functions
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

    func clearTableView() {
        messages.removeAll()
        messageDictionary.removeAll()
        tableView.reloadData()
        observeUserMessages()
    }
}
