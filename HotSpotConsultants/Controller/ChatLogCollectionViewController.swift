//
//  ChatLogTableViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-12.8
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class ChatLogCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    let cellID = "cellID"
    var messages = [Message]()
    var containerViewBottomAnchor : NSLayoutConstraint?

    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background image
        let backgroundImageView = UIImageView(image: UIImage(named: "snowMountain"))
        backgroundImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = backgroundImageView
        
        //Navigation bar items
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        
        //Set up view
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
        collectionView.alwaysBounceVertical = true
        collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellID)
        
        //Handle keyboard
        collectionView.keyboardDismissMode = .interactive

    }
    
    //Not sure if needed?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Computed properties
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
    var user : User? {
        didSet {
            navigationItem.title = user?.name
            observeMessage()
        }
    }
    //Text field
    lazy var inputContainerView : UIView = {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 84)
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        let sendButton = UIButton(type: .system)
        sendButton.setTitle("send", for: .normal)
        sendButton.setTitleColor(#colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1), for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        
        containerView.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        containerView.addSubview(self.inputTextfield)
        self.inputTextfield.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        self.inputTextfield.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6).isActive = true
        self.inputTextfield.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        self.inputTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return containerView
    }()
    //get keyboard nicely
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }

    //MARK: Functions
    private func observeMessage() {
        guard let uid = Auth.auth().currentUser?.uid, let toID = user?.id else {return}
        let userMessagesRef = Database.database().reference().child("user-messages").child(uid).child(toID)
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            let messageID = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(messageID)
            
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
                let message = Message()
                message.fromID = dictionary["fromID"] as? String
                message.text = (dictionary["text"] as? String?)!
                message.timestamp = dictionary["timestamp"] as? NSNumber
                message.toID = dictionary["toID"] as? String
                
                self.messages.append(message)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    @objc private func handleSendMessage() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let messagesRef = ref.child("messages")
        let childRef = messagesRef.childByAutoId()
        
        let toID = user!.id!
        let fromID = Auth.auth().currentUser!.uid
        let timestamp : NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let values = ["text" : inputTextfield.text!, "toID" : toID, "fromID" : fromID, "timestamp" : timestamp] as [String : Any]
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error ?? "error in ChatLogCollectionViewController.handleSendMessage()")
                return
            }
            
            self.inputTextfield.text = nil
            
            guard let messageId = childRef.key else { return }
            let userMessagesRef = Database.database().reference().child("user-messages").child(fromID).child(toID).child(messageId)
            userMessagesRef.setValue(1)
            let recipientUserMessagesRef = Database.database().reference().child("user-messages").child(toID).child(fromID).child(messageId)
            recipientUserMessagesRef.setValue(1)
        }
    }
 
    //Fix so it looks good when rotating the device
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //Setup chat bubbles
    private func setupCell(cell: ChatMessageCell, message: Message) {
        if let profileImageUrl = self.user?.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithURLString(urlString: profileImageUrl)
        }
        if message.fromID == Auth.auth().currentUser?.uid {
            //outgoing blue bubble
            cell.bubbleView.backgroundColor = ChatMessageCell.blueColor
            cell.textView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
            cell.profileImageView.isHidden = true
        } else {
            //incoming grey bubble
            cell.bubbleView.backgroundColor = ChatMessageCell.greyColor
            cell.textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
            cell.profileImageView.isHidden = false
        }
    }
    
    //Send message when hitting enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSendMessage()
        return true
    }
    
    private func estimatedFrameForText(text : String) -> CGRect{
        let size = CGSize(width: view.bounds.width*2/3, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], context: nil)
    }
    
    // MARK: - Collection view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]
        cell.textView.text = messages[indexPath.row].text
        setupCell(cell: cell, message: message)
        cell.bubbleWidthAnchor?.constant = estimatedFrameForText(text: message.text!).width + 32
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = 80
        
        if let text = messages[indexPath.row].text {
            height = estimatedFrameForText(text: text).height + 20
        }
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
}
