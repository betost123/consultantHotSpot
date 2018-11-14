//
//  MyProfileViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-10-31.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground(imageName: "snowMountain", contentMode: .scaleAspectFill)
        
        let logOutButton = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.leftBarButtonItem = logOutButton
        
        let chatButton = UIBarButtonItem(title: "chat", style: .plain, target: self, action: #selector(handleMessages))
        self.navigationItem.rightBarButtonItem = chatButton
        
        //temporary, has to be in scroll view later!
        /*
        view.addSubview(contactButton)
        contactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        contactButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 213).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
         */
 
        //if user aint logged in then kick him out
        checkIfUserIsLoggedIn()

        //observeMessages()
    }
    /*
    var messages = [Message]()
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
           
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let message = Message()
                message.setValuesForKeys(dictionary)
                
                self.messages.append(message)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
            
            
        }, withCancel: nil)
    }
 
    //FIXME: HÄR
    override func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.toID
        cell.detailTextLabel?.text = message.text
        
        return cell
    }
    */
    
    @objc func showChatControllerForUser(user: User) {
        let chatLogController = ChatLogCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //FIXME: set left nav item title to "Profile"
        chatLogController.user = user
        
        navigationController?.pushViewController(chatLogController, animated: true)
        
    }
    
    //top right bar button item
    @objc func handleMessages() {
        let chatsController = ChatsTableViewController()
        //chatsController.contactThingy = self
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
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let lvc = storyboard.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
        //self.present(lvc, animated: true, completion: nil)
    }
    
    //MARK: Properties
    let contactButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        button.setTitle("contact", for: .normal)
        //button.addTarget(self, action: #selector(showChatControllerForUser(user:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

}
