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
        tv.text = "SAMLE TEXT LALLA LALLA LALLA"
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tv.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 0.8598030822)
        tv.layer.cornerRadius = 15
        tv.layer.masksToBounds = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textView)
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
