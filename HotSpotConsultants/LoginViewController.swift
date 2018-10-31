//
//  LoginViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-10-30.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let inputsContainerView : UIView = {
       let cv = UIView()
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.75)
        cv.layer.cornerRadius = 5
        cv.layer.masksToBounds = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addBackground(imageName: "snowMountain", contentMode: .scaleAspectFill)
        setupView()

        
    }
    
    //MARK: Text Fields
    let mailTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "email"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let fieldSeparator : UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    let passwordTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "password"
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //MARK: Buttons
    let loginButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        button.setTitle("log in", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func loginAction(sender: UIButton!) {
        print("login!")
    }
    let registerButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        button.setTitle("register an account", for: .normal)
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func registerAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rvc = storyboard.instantiateViewController(withIdentifier: "registerView") as! RegisterViewController
        self.present(rvc, animated: true, completion: nil)
    }
    
    //MARK: Labels
    let navigationLabel : UILabel = {
        let label = UILabel()
        label.text = "GET IN CONTACT"
        label.font = UIFont.boldSystemFont(ofSize: 36.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Setup
    func setupView() {
        view.addSubview(inputsContainerView)
        inputsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 40*3).isActive = true
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        inputsContainerView.addSubview(mailTextField)
        mailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        mailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        mailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1)
        mailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        inputsContainerView.addSubview(fieldSeparator)
        fieldSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        fieldSeparator.topAnchor.constraint(equalTo: mailTextField.bottomAnchor).isActive = true
        fieldSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -16).isActive = true
        fieldSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 0).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
        inputsContainerView.addSubview(loginButton)
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        loginButton.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        view.addSubview(registerButton)
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 0).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        
        
        view.addSubview(navigationLabel)
        navigationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        navigationLabel.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -20).isActive = true
        navigationLabel.heightAnchor.constraint(equalToConstant: 91.0).isActive = true
        navigationLabel.widthAnchor.constraint(equalToConstant: 201.0).isActive = true
        
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
