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
        
        checkIfUserIsLoggedIn()

    }
    
    @objc func handleMessages() {
        let chatsController = ChatsTableViewController()
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lvc = storyboard.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
        self.present(lvc, animated: true, completion: nil)
    }
    

}
