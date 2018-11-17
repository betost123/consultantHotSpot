//
//  UserCell.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-17.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class UserCell : UITableViewCell {
    
    var message : Message? {
        didSet {
            setupNameAndAvatar()
            
            detailTextLabel?.text = message?.text
            
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = NSDate(timeIntervalSince1970: seconds)
                let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "hh:mm:ss"
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm, MMMd") // set template after setting locale
                timeLabel.text = dateFormatter.string(from: timestampDate as Date)
            }

        }
    }
    
    private func setupNameAndAvatar() {
        let chatPartnerID : String?
        
        if message?.fromID == Auth.auth().currentUser?.uid {
            chatPartnerID = message?.toID
        } else {
            chatPartnerID = message?.fromID
        }
        
        //set name as "message title"
        if let id = chatPartnerID {
            let ref = Database.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    self.textLabel?.text = dictionary["name"] as? String
                    
                    if let profileImgageUrl = dictionary["profileImageUrl"] as? String {
                        self.profileImageView.loadImageUsingCacheWithURLString(urlString: profileImgageUrl)
                    }
                }
            }, withCancel: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 1, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 1, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24 //half of width/height
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addSubview(timeLabel)
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
}
