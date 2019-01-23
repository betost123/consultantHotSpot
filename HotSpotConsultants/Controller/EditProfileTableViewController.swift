//
//  EditProfileTableViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-12-06.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class EditProfileTableViewController: UITableViewController, UITextFieldDelegate, ShortInfoEditCellDelegate {
    var profileTitle : String?
    var profileName : String?
    var profileGithub : String?
    var profileCity : String?
    var profileMail : String?
    let cellID = "cellID"
    let cellIDs = "cellIDs"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadValuesFromDatabase()

        //Bakground image
        let backgroundImageView = UIImageView(image: UIImage(named: "snowMountain"))
        backgroundImageView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImageView
        
        //Navigation bar
        self.navigationItem.title = "Edit profile"
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneButtonHandler))
        self.navigationItem.rightBarButtonItem = doneButton
        
        //table view related information
        tableView.register(EditProfilePictureCell.self, forCellReuseIdentifier: cellID)
        tableView.register(ShortInfoEditCell.self, forCellReuseIdentifier: cellIDs)
        
        //keyboard handle
        tableView.keyboardDismissMode = .interactive
        
        
    }
    
    func nameChanged(name: String) {
        profileName = name
    }
    
    func titleChanged(title: String) {
        profileTitle = title
    }
    
    func githubChanged(github: String) {
        profileGithub = github
    }
    
    func cityChanged(city: String) {
        profileCity = city
    }
    
    func mailChanged(mail: String) {
        profileMail = mail
    }
    
    func loadValuesFromDatabase() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                if let name = dictionary["name"] as? String, let mail = dictionary["mail"] as? String {
                    self.profileName = name
                    self.profileMail = mail
                    
                }
            } else {
               self.profileName = "your name"
                self.profileMail = "your@mail.se"
            }
            
            //Update view
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)
        
        Database.database().reference().child("userInfo").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                if let title = dictionary["title"] as? String, let github = dictionary["github"] as? String, let city = dictionary["city"] as? String {
                    self.profileTitle = title
                    self.profileGithub = github
                    self.profileCity = city
                }
            } else {
                self.profileTitle = "yout title"
                self.profileGithub = "your github"
                self.profileMail = "your github"
            }
            
            //Update view
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)
        
    }

    //FIXME: Once implementation done, return x + earlierWorkExperience.count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EditProfilePictureCell
            cell.selectionStyle = .none
            
            //Get user from database
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    if let imgURL = dictionary["profileImageUrl"] as? String {
                        cell.profilePicture.loadImageUsingCacheWithURLString(urlString: imgURL)
                    }
                }
            }, withCancel: nil)
            
            cell.backgroundColor = UIColor.clear
            
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDs, for: indexPath) as! ShortInfoEditCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none //non-selectable
            
            cell.nameEditInputTextField.text = profileName
            cell.mailEditInputTextField.text = profileMail
            cell.titleEditInputTextField.text = profileTitle
            cell.githubEditInputTextField.text = profileGithub
            cell.cityEditInputTextField.text = profileCity
            
            //när delegaten säger
            cell.delegate = self
            
            return cell
            
        }
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "thirdCustomCell")
            //set the data here
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor.clear
            return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //edit picture cell
            return (100+25+8+10+6)
        }
        return 45*5+4 //edit field plus separator
    }

    //Create or add node of information to user
    @objc func doneButtonHandler() {

        //Register into database
        //let values = ["title" : title, "github" : github, "city" : city]
        let uid = Auth.auth().currentUser?.uid
        let values = ["title" : profileTitle, "github" : profileGithub, "city" : profileCity]
        self.registerInfoIntoDatabaseWithUID(uid: uid!, values: values as [String : AnyObject])
        
        //Update view
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    //Register into database
    private func registerInfoIntoDatabaseWithUID(uid : String, values : [String : AnyObject]) {
        var ref : DatabaseReference!
        ref = Database.database().reference()
        let userInfoRef = ref.child("userInfo").child(uid)
        
        userInfoRef.updateChildValues(values) { (err, ref) in
            if err != nil {
                print(err ?? "error EditProfileTableViewController.registerInfoIntoDatabaseWithUID")
                return
            }
            
            print("Successfully added user information from text field")
        }
    }
    
    //text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
 
    // MARK: - Table view data source
    
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 3
     }
     */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





struct UserInfoForTableCell {
    var name : String?
    var title : String?
    var github : String?
    var city : String?
}
