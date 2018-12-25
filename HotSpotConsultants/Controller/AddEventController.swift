//
//  AddEvent.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-12-23.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import Foundation
import UIKit

class AddEventController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         view.addBackground(imageName: "snowMountain", contentMode: .scaleAspectFill)
        
        self.navigationItem.title = "Add event"
        
        setupView()
    }
    
    @objc func addEventButtonHandler() {
        print("Add event!")
    }
    
    
    //MARK: inputsContainerView
    private let inputsContainerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.75)
        cv.layer.cornerRadius = 5
        cv.layer.masksToBounds = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //MARK: Text Fields
    private let nameTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "event name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let nameSeparator : UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    private let hostTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "event host"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let hostSeparator : UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    private let longitudinalTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "longitudinal coordinate"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let longitudinalSeparator : UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    private let latitudinalTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "latitudinal coordinate"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //MARK: Buttons
    private let addEventButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        button.setTitle("add event", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(addEventButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Setup
    private func setupView() {
        view.addSubview(inputsContainerView)
        inputsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 40*5).isActive = true
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1)
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        inputsContainerView.addSubview(nameSeparator)
        nameSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -16).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(hostTextField)
        hostTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        hostTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 0).isActive = true
        hostTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1)
        hostTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        inputsContainerView.addSubview(hostSeparator)
        hostSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        hostSeparator.topAnchor.constraint(equalTo: hostTextField.bottomAnchor).isActive = true
        hostSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -16).isActive = true
        hostSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(longitudinalTextField)
        longitudinalTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        longitudinalTextField.topAnchor.constraint(equalTo: hostTextField.bottomAnchor, constant: 0).isActive = true
        longitudinalTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        longitudinalTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        inputsContainerView.addSubview(longitudinalSeparator)
        longitudinalSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        longitudinalSeparator.topAnchor.constraint(equalTo: longitudinalTextField.bottomAnchor).isActive = true
        longitudinalSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -16).isActive = true
        longitudinalSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(latitudinalTextField)
        latitudinalTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        latitudinalTextField.topAnchor.constraint(equalTo: longitudinalTextField.bottomAnchor, constant: 0).isActive = true
        latitudinalTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        latitudinalTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
        
        inputsContainerView.addSubview(addEventButton)
        addEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        addEventButton.topAnchor.constraint(equalTo: latitudinalTextField.bottomAnchor, constant: 0).isActive = true
        addEventButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        addEventButton.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5).isActive = true
      
    }
}
