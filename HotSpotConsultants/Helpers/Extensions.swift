
//
//  Extensions.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-11-09.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithURLString(urlString: String) {
        //check cache for image first
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error ?? "error chats->cellForRow, Image")
                return
            }
            
            DispatchQueue.main.async {
                 let imageToCache = UIImage(data: data!) //{
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                //}
            }
                
            
        }).resume()
    }
}
