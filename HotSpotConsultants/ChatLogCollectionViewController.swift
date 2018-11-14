//
//  ChatLogTableViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-12.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class ChatLogCollectionViewController: UICollectionViewController, UITextFieldDelegate {
    
    //MARK: Properties
    var user : User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    lazy var inputTextfield : UITextField = {
        let tf = UITextField()
        tf.placeholder = " message"
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.layer.cornerRadius = 20.0
        tf.layer.masksToBounds = true
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "snowMountain")!)
        
        //navigationItem.title = "Chat Controller"
        
        setupInputComponents()
    }
    
    @objc func handleSendMessage() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let messagesRef = ref.child("messages")
        let childRef = messagesRef.childByAutoId()
        
        let toID = user!.id!
        let fromID = Auth.auth().currentUser!.uid
        let timestamp : NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let values = ["text" : inputTextfield.text!, "toID" : toID, "fromID" : fromID, "timestamp" : timestamp] as [String : Any]
        childRef.updateChildValues(values as [AnyHashable : Any])
    }
    
    func setupInputComponents() {
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        
        containerView.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextfield)
        inputTextfield.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextfield.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextfield.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextfield.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.85).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSendMessage()
        return true
    }
    
    // MARK: - Table view data source
    
}
