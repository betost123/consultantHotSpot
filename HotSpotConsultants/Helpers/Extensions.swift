
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

extension UIView {
    func addBackground(imageName: String = "snowMountain", contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
