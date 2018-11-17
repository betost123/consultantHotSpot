//
//  TabBarController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-15.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let firstVC = ChatController()
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let tabBarList = [firstVC]
        
        viewControllers = tabBarList
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
