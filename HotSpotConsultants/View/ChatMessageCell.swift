//
//  ChatMessageCell.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-18.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit

class ChatMessageCell : UICollectionViewCell {
    let textView : UITextView = {
        let tv = UITextView()
        //tv.text = "SAMLE TEXT LALLA LALLA LALLA"
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tv.backgroundColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var bubbleWidthAnchor : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        
        addSubview(textView)
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 0.8598030822)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
