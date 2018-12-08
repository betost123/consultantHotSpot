//
//  EditProfileTableViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-12-06.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class EditProfileTableViewController: UITableViewController {
    let cellID = "cellID"
    let cellIDs = "cellIDs"

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImageView = UIImageView(image: UIImage(named: "snowMountain"))
        backgroundImageView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImageView
        
        self.navigationItem.title = "Edit profile"
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneButtonHandler))
        self.navigationItem.rightBarButtonItem = doneButton
        
        tableView.register(EditProfilePictureCell.self, forCellReuseIdentifier: cellID)
        tableView.register(ShortInfoEditCell.self, forCellReuseIdentifier: cellIDs)
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
 */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EditProfilePictureCell
            
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
        } else if indexPath.row > 0 && indexPath.row <= 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDs, for: indexPath) as! ShortInfoEditCell
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    switch indexPath.row {
                    case 1:
                        if let name = dictionary["name"] as? String {
                            cell.objectLabel.text = "Name"
                            cell.editInputTextField.text = name
                        }
                    case 2:
                        cell.objectLabel.text = "Title"
                        cell.editInputTextField.placeholder = "SOFTWARE ENGINEER"
                    case 3:
                        cell.objectLabel.text = "Github"
                        cell.editInputTextField.placeholder = "betost123@github"
                    case 4:
                        cell.objectLabel.text =  "City"
                        cell.editInputTextField.placeholder = "LINKÖPING, SWE"
                    case 5:
                        cell.objectLabel.text = "Mail"
                        cell.editInputTextField.placeholder = "betina@mail.se"
                    default:
                        cell.objectLabel.text = ""
                    }
                }
            }, withCancel: nil)
            
        }
        
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "thirdCustomCell")
            //set the data here
            cell.backgroundColor = UIColor.clear
            return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (100+25+8+10+6)
        }
        return 48
    }
    
    @objc func doneButtonHandler() {
        print("user is done editing")
    }
    

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
