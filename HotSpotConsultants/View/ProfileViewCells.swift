//
//  ProfileViewCells.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-12-06.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit

class ProfileHeaderCell : UITableViewCell {
    
    let contactButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        button.setTitle("edit", for: .normal)
        button.addTarget(self, action: #selector(ProfileTableViewController.goToEditView), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let profilePicture : UIImageView = {
        let pic = UIImageView()
        //pic.image = UIImage(named: "profilePictureIcon")
        pic.layer.cornerRadius = 110/2
        pic.layer.masksToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    let navigationLabel : UILabel = {
        let label = UILabel()
        //label.text = "BETINA ANDERSSON"
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
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let skillsTextView  : UITextView = {
        let textView = UITextView()
        textView.text = "Swift, c#, Java, Unix, iOS development, C, Arduino, Scrum, Unity 3D, MatLab, HTML, CSS, JavaScript, C"
        textView.font = UIFont.systemFont(ofSize: 15)
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
        skillsContainerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        skillsContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        skillsContainerView.addSubview(skillsLabel)
        skillsLabel.leadingAnchor.constraint(equalTo: skillsContainerView.leadingAnchor, constant: 6).isActive = true
        skillsLabel.topAnchor.constraint(equalTo: skillsContainerView.topAnchor, constant: 3).isActive = true
        skillsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        skillsLabel.trailingAnchor.constraint(equalTo: skillsContainerView.trailingAnchor, constant: -6).isActive = true
        
        skillsContainerView.addSubview(skillsTextView)
        skillsTextView.leadingAnchor.constraint(equalTo: skillsContainerView.leadingAnchor, constant: 6).isActive = true
        skillsTextView.topAnchor.constraint(equalTo: skillsLabel.topAnchor, constant: 10).isActive = true
        skillsTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aboutTextView  : UITextView = {
        let textView = UITextView()
        textView.text = "En nyfiken och glad programmerare som läste Datateknik Högskoelinegnjör på Chalmers. Tog examen 2018 och har sedan dess jobbat som konsult. Brinner för utveckling inom front end och maskinnära skapelser. Har erfarenhet inom iOS utveckling samt konfigurering av operativsystem för radars. Drivs av utmaningar och har ett genuint intresse för att bredda mina kunskaper."
        textView.font = UIFont.systemFont(ofSize: 15)
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
        aboutContainerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        aboutContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        aboutContainerView.addSubview(aboutLabel)
        aboutLabel.leadingAnchor.constraint(equalTo: aboutContainerView.leadingAnchor, constant: 6).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: aboutContainerView.topAnchor, constant: 8).isActive = true
        aboutLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        aboutLabel.trailingAnchor.constraint(equalTo: aboutContainerView.trailingAnchor, constant: -6).isActive = true
        
        aboutContainerView.addSubview(aboutTextView)
        aboutTextView.leadingAnchor.constraint(equalTo: aboutContainerView.leadingAnchor, constant: 6).isActive = true
        aboutTextView.topAnchor.constraint(equalTo: aboutLabel.topAnchor, constant: 10).isActive = true
        aboutTextView.heightAnchor.constraint(equalTo: aboutContainerView.heightAnchor, multiplier: 0.9).isActive = true
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
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyNameLabel : UILabel = {
        let label = UILabel()
        label.text = " Aptiv"
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "feb - sep, 2018"
        label.font = label.font.withSize(15)
        label.textAlignment = NSTextAlignment.right
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let cityLabel : UILabel = {
        let label = UILabel()
        label.text = "Göteborg"
        label.font = label.font.withSize(15)
        label.textAlignment = NSTextAlignment.right
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionTextView  : UITextView = {
        let textView = UITextView()
        textView.text = "Jobbade med ett kollisionsvarningssystem för spårvagnar. Arbetet innefattade programmering i MatLab och c++, samt byggade av hårdvara till radars. Gav my..."
        textView.font = UIFont.systemFont(ofSize: 15)
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


//MARK: For edit view controller

class EditProfilePictureCell : UITableViewCell {
    
    let profilePicture : UIImageView = {
        let pic = UIImageView()
        pic.layer.cornerRadius = 100/2
        pic.layer.masksToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    let editProfilePictureButton : UIButton = {
        let button = UIButton()
        button.setTitle("edit profile picture", for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(profilePicture)
        profilePicture.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profilePicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(editProfilePictureButton)
        editProfilePictureButton.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 8).isActive = true
        editProfilePictureButton.centerXAnchor.constraint(equalTo: profilePicture.centerXAnchor).isActive = true
        editProfilePictureButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        editProfilePictureButton.heightAnchor.constraint(equalToConstant: 25).isActive = true

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
    
}

class ShortInfoEditCell : UITableViewCell {
    let containerView : UIView = {
        let container = UIView()
        //container.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let objectLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editInputTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Betina Andersson"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        containerView.addSubview(objectLabel)
        objectLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        objectLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        objectLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        objectLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        containerView.addSubview(editInputTextField)
        editInputTextField.leftAnchor.constraint(equalTo: objectLabel.rightAnchor, constant: 1).isActive = true
        editInputTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        editInputTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        editInputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
}
