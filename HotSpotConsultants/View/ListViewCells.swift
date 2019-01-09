//
//  ListViewCells.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2019-01-08.
//  Copyright © 2019 Betina Andersson. All rights reserved.
//

import Foundation
import UIKit

class eventCell : UITableViewCell {
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomBarView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        containerView.addSubview(bottomBarView)
        bottomBarView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        bottomBarView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomBarView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        bottomBarView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        bottomBarView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: bottomBarView.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: bottomBarView.widthAnchor, multiplier: 1/4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: bottomBarView.leadingAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: bottomBarView.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
