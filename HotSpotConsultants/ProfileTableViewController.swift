//
//  ProfileTableViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-28.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {
    //MARK: Variables
    let cellIDp = "cellIDp"
    let cellIDs = "cellIDs"
    let cellIDa = "cellIDa"
    let cellIDe = "cellIDe"
    var experiences = [Experience]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImageView = UIImageView(image: UIImage(named: "snowMountain"))
        backgroundImageView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImageView
        
        //Navigation bar items
        self.navigationItem.title = "My Profile"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        let logOutButton = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.leftBarButtonItem = logOutButton
        let settingsButton = UIBarButtonItem(title: "settings", style: .plain, target: self, action: #selector(settingsButtonHandler))
        self.navigationItem.rightBarButtonItem = settingsButton
        
        //register cells
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: cellIDp)
        tableView.register(SkillsCell.self, forCellReuseIdentifier: cellIDs)
        tableView.register(AboutMeCell.self, forCellReuseIdentifier: cellIDa)
        tableView.register(EarlierExperienceCell.self, forCellReuseIdentifier: cellIDe)


        checkIfUserIsLoggedIn()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
    }
    
    @objc func goToEditView() {
        let editController = EditProfileTableViewController()
        navigationController?.pushViewController(editController, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 + experiences.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDp, for: indexPath) as! ProfileHeaderCell
            
            //Get user from database
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    cell.navigationLabel.text = dictionary["name"] as? String
                    if let imgURL = dictionary["profileImageUrl"] as? String {
                        cell.profilePicture.loadImageUsingCacheWithURLString(urlString: imgURL)
                    }
                }
            }, withCancel: nil)
            Database.database().reference().child("userInfo").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    cell.professionLabel.text = dictionary["title"] as? String
                }
            }, withCancel: nil)
 
            cell.backgroundColor = UIColor.clear
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDs, for: indexPath) as! SkillsCell
            cell.backgroundColor = UIColor.clear
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDa, for: indexPath) as! AboutMeCell
            cell.backgroundColor = UIColor.clear
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDe, for: indexPath) as! EarlierExperienceCell
            cell.backgroundColor = UIColor.clear
            return cell
        }
        else {
            //let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "thirdCustomCell")
            //set the data here
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDe, for: indexPath) as! EarlierExperienceCell
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 210
        } else if indexPath.row == 1 {
            return 75
        } else if indexPath.row == 2 {
            return 190
        } else if indexPath.row == 3 {
            return 150
        }
        return 150
    }
    
    
    
    //MARK: User related info
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            //user isn't logged in
            perform(#selector(logOut), with: nil, afterDelay: 0) //present controller after it's loaded
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
        loginController.profileControllerTableView = self
        present(loginController, animated: true, completion: nil)
    }
    
    @objc func settingsButtonHandler() {
        print("go to settings")
    }

}
