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
    let cellIDp = "cellIDp"
    let cellIDs = "cellIDs"
    let cellIDa = "cellIDa"
    let cellIDe = "cellIDe"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImageView = UIImageView(image: UIImage(named: "snowMountain"))
        backgroundImageView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImageView
        //Navigation bar items
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        let logOutButton = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.leftBarButtonItem = logOutButton
        
        //register cells
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: cellIDp)
        tableView.register(SkillsCell.self, forCellReuseIdentifier: cellIDs)
        tableView.register(AboutMeCell.self, forCellReuseIdentifier: cellIDa)
        tableView.register(EarlierExperienceCell.self, forCellReuseIdentifier: cellIDe)


        checkIfUserIsLoggedIn()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDp, for: indexPath) as! ProfileHeaderCell
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
            return 160
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
        loginController.profileControllerTableView = self
        present(loginController, animated: true, completion: nil)
    }

}


//------------------------------------------------------------------


//Flytta dessa celler till "view" sen?

class ProfileHeaderCell : UITableViewCell {
    let contactButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        button.setTitle("edit", for: .normal)
        //button.addTarget(self, action: #selector(showChatControllerForUser(user:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let profilePicture : UIImageView = {
        let pic = UIImageView()
        pic.image = UIImage(named: "profilePictureIcon")
        pic.layer.cornerRadius = 110/2
        pic.layer.masksToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    let navigationLabel : UILabel = {
        let label = UILabel()
        label.text = "BETINA ANDERSSON"
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let professionLabel : UILabel = {
        let label = UILabel()
        label.text = "SOFTWARE ENGINEER"
        label.font = label.font.withSize(17.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let githubLabel : UILabel = {
        let label = UILabel()
        label.text = "github@betost123"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityLabel : UILabel = {
        let label = UILabel()
        label.text = "LINKÖPING, SWE"
        label.font = label.font.withSize(17.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(profilePicture)
        profilePicture.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        profilePicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 110).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        addSubview(contactButton)
        contactButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        contactButton.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 12).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        addSubview(navigationLabel)
        navigationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        navigationLabel.topAnchor.constraint(equalTo: profilePicture.topAnchor, constant: 0).isActive = true
        navigationLabel.heightAnchor.constraint(equalToConstant: 91.0).isActive = true
        navigationLabel.trailingAnchor.constraint(equalTo: profilePicture.leadingAnchor, constant: -8).isActive = true
        
        addSubview(professionLabel)
        professionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        professionLabel.topAnchor.constraint(equalTo: navigationLabel.bottomAnchor, constant: 7).isActive = true
        professionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        professionLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(githubLabel)
        githubLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        githubLabel.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 7).isActive = true
        githubLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        githubLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(cityLabel)
        cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        cityLabel.topAnchor.constraint(equalTo: githubLabel.bottomAnchor, constant: 7).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        cityLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
    
}

class SkillsCell : UITableViewCell {
    let skillsContainerView : UIView = {
        let scv = UIView()
        scv.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        scv.translatesAutoresizingMaskIntoConstraints = false
        return scv
    }()
    
    let skillsLabel : UILabel = {
        let label = UILabel()
        label.text = " Skills"
        label.textColor = #colorLiteral(red: 0.8801551461, green: 0.6339178681, blue: 0.6032804847, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let skillsTextView  : UITextView = {
        let textView = UITextView()
        textView.text = "Swift, c#, Java, Unix, iOS development, C, Arduino, Scrum, Unity 3D, MatLab, HTML, CSS, JavaScript, C"
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(skillsContainerView)
        skillsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        skillsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        skillsContainerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skillsContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        skillsContainerView.addSubview(skillsLabel)
        skillsLabel.leadingAnchor.constraint(equalTo: skillsContainerView.leadingAnchor, constant: 6).isActive = true
        skillsLabel.topAnchor.constraint(equalTo: skillsContainerView.topAnchor, constant: 3).isActive = true
        skillsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        skillsLabel.trailingAnchor.constraint(equalTo: skillsContainerView.trailingAnchor, constant: -6).isActive = true
        
        skillsContainerView.addSubview(skillsTextView)
        skillsTextView.leadingAnchor.constraint(equalTo: skillsContainerView.leadingAnchor, constant: 6).isActive = true
        skillsTextView.topAnchor.constraint(equalTo: skillsLabel.topAnchor, constant: 10).isActive = true
        skillsTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        skillsTextView.trailingAnchor.constraint(equalTo: skillsContainerView.trailingAnchor, constant: -6).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
}

class AboutMeCell : UITableViewCell {
    let aboutContainerView : UIView = {
        let acv = UIView()
        acv.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.850786601)
        acv.translatesAutoresizingMaskIntoConstraints = false
        return acv
    }()
    
    let aboutLabel : UILabel = {
        let label = UILabel()
        label.text = " About me"
        label.textColor = #colorLiteral(red: 0.8801551461, green: 0.6339178681, blue: 0.6032804847, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aboutTextView  : UITextView = {
        let textView = UITextView()
        textView.text = "En nyfiken och glad programmerare som läste Datateknik Högskoelinegnjör på Chalmers. Tog examen 2018 och har sedan dess jobbat som konsult. Brinner för utveckling inom front end och maskinnära skapelser. Har erfarenhet inom iOS utveckling samt konfigurering av operativsystem för radars. Drivs av utmaningar och har ett genuint intresse för att bredda mina kunskaper."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(aboutContainerView)
        aboutContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        aboutContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        aboutContainerView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        aboutContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        aboutContainerView.addSubview(aboutLabel)
        aboutLabel.leadingAnchor.constraint(equalTo: aboutContainerView.leadingAnchor, constant: 6).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: aboutContainerView.topAnchor, constant: 8).isActive = true
        aboutLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        aboutLabel.trailingAnchor.constraint(equalTo: aboutContainerView.trailingAnchor, constant: -6).isActive = true
        
        aboutContainerView.addSubview(aboutTextView)
        aboutTextView.leadingAnchor.constraint(equalTo: aboutContainerView.leadingAnchor, constant: 6).isActive = true
        aboutTextView.topAnchor.constraint(equalTo: aboutLabel.topAnchor, constant: 10).isActive = true
        aboutTextView.heightAnchor.constraint(equalTo: aboutContainerView.heightAnchor, multiplier: 0.8).isActive = true
        aboutTextView.trailingAnchor.constraint(equalTo: aboutContainerView.trailingAnchor, constant: -6).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
    
    
}

class EarlierExperienceCell : UITableViewCell {
    let experienceContainerView : UIView = {
        let acv = UIView()
        acv.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        acv.translatesAutoresizingMaskIntoConstraints = false
        return acv
    }()
    
    let workTitleLabel : UILabel = {
        let label = UILabel()
        label.text = " Student Engineer"
        label.textColor = #colorLiteral(red: 0.8801551461, green: 0.6339178681, blue: 0.6032804847, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyNameLabel : UILabel = {
       let label = UILabel()
        label.text = " Aptiv"
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "feb - sep, 2018"
        label.font = label.font.withSize(13)
        label.textAlignment = NSTextAlignment.right
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let cityLabel : UILabel = {
        let label = UILabel()
        label.text = "Göteborg"
        label.font = label.font.withSize(13)
        label.textAlignment = NSTextAlignment.right
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionTextView  : UITextView = {
        let textView = UITextView()
        textView.text = "Jobbade med ett kollisionsvarningssystem för spårvagnar. Arbetet innefattade programmering i MatLab och c++, samt byggade av hårdvara till radars. Gav my..."
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(experienceContainerView)
        experienceContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        experienceContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        experienceContainerView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        experienceContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        experienceContainerView.addSubview(workTitleLabel)
        workTitleLabel.leadingAnchor.constraint(equalTo: experienceContainerView.leadingAnchor, constant: 6).isActive = true
        workTitleLabel.topAnchor.constraint(equalTo: experienceContainerView.topAnchor, constant: 8).isActive = true
        workTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        workTitleLabel.widthAnchor.constraint(equalTo: experienceContainerView.widthAnchor, multiplier: 0.5).isActive = true

        experienceContainerView.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: workTitleLabel.topAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: experienceContainerView.rightAnchor, constant: -8).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: workTitleLabel.heightAnchor, constant: 0).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: experienceContainerView.widthAnchor, multiplier: 0.5).isActive = true
        
        experienceContainerView.addSubview(companyNameLabel)
        companyNameLabel.leadingAnchor.constraint(equalTo: experienceContainerView.leadingAnchor, constant: 6).isActive = true
        companyNameLabel.topAnchor.constraint(equalTo: workTitleLabel.bottomAnchor, constant: 5).isActive = true
        companyNameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        companyNameLabel.widthAnchor.constraint(equalTo: experienceContainerView.widthAnchor, multiplier: 0.5).isActive = true
        
        experienceContainerView.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: experienceContainerView.rightAnchor, constant: -8).isActive = true
        cityLabel.heightAnchor.constraint(equalTo: workTitleLabel.heightAnchor, constant: 0).isActive = true
        cityLabel.widthAnchor.constraint(equalTo: experienceContainerView.widthAnchor, multiplier: 0.5).isActive = true
        
        experienceContainerView.addSubview(descriptionTextView)
        descriptionTextView.leadingAnchor.constraint(equalTo: experienceContainerView.leadingAnchor, constant: 5).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.heightAnchor.constraint(equalTo: experienceContainerView.heightAnchor, multiplier: 0.7).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: experienceContainerView.trailingAnchor, constant: -6).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
}
