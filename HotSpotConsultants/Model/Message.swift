//
//  Message.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-13.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var fromID : String?
    var text : String?
    var timestamp : NSNumber?
    var toID : String?
    
    func chatPartnerID() -> String? {
        return fromID == Auth.auth().currentUser?.uid ? toID : fromID
    }
}
