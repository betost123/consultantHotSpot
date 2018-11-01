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
        self.title = "My Profile"
        view.addBackground(imageName: "snowMountain", contentMode: .scaleAspectFill)
        
        let logOutButton = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.leftBarButtonItem = logOutButton
        
        if Auth.auth().currentUser?.uid == nil {
            //user isn't logged in
            perform(#selector(logOut), with: nil, afterDelay: 0) //present controller after it's loaded
        }

    }
    
    @objc func logOut() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lvc = storyboard.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
        self.present(lvc, animated: true, completion: nil)
    }
    

}
