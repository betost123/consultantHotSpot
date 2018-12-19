//
//  RegisterViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-10-30.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addBackground(imageName: "snowMountain", contentMode: .scaleAspectFill)
        setupView()
        
        addProfilePictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfilePictureImage)))
        addProfilePictureImageView.isUserInteractionEnabled = true
        
    }
    
    //MARK: Functions
    @objc func handleSelectProfilePictureImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker : UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            addProfilePictureImageView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func returnToLoginAction(sender: UIButton!) {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    @objc func registerAction(sender: UIButton!) {
        guard let mail = mailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: mail, password: password) { (authResult, error) in
            // ...
            if error != nil {
                print("error creating user")
                print(error ?? "error")
                return
            }
            guard let user = authResult?.user else { return }
            
            let imageName = NSUUID().uuidString //gives a unique string
            let storage = Storage.storage()
            let storageRef = storage.reference().child("profileImages").child("\(imageName).png")
            
            //image compression
            if let profileImage = self.addProfilePictureImageView.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error ?? "error upload data")
                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        guard let downloadURL = url?.absoluteString else {
                            //uh-oh an error occured!
                            return
                        }
                        
                        let values = ["name" : name, "mail" : mail, "profileImageUrl" : downloadURL]
                        self.registerUserIntoDatabaseWithUID(uid: user.uid, values: values as [String : AnyObject])
                    })
                    
                    
                })
            }
            

        }
    }
    
    //MARK: Register user into database
    //let values = ["name" : name, "mail" : mail, "profileImageUrl" : downloadURL]
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let usersRef = ref.child("users").child(uid)
        
        usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err ?? "error")
                return
            }
            //FIXME: Bugs out because of dismiss, make some sort of hidden view to the Login Controller
            print("saved user successfully into firebase db")
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    //MARK: inputsContainerView
    let inputsContainerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.75)
        cv.layer.cornerRadius = 5
        cv.layer.masksToBounds = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //MARK: Text Fields
    let nameTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let nameSeparator : UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
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
    let registerButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red:0.88, green:0.64, blue:0.60, alpha:1.0)
        button.setTitle("register", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let returnToLoginButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        button.setTitle("return to login", for: .normal)
        button.addTarget(self, action: #selector(returnToLoginAction), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
    
    //MARK: Labels
    let navigationLabel : UILabel = {
        let label = UILabel()
        label.text = "REGISTER"
        label.font = UIFont.boldSystemFont(ofSize: 36.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Images
    let addProfilePictureImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilePictureIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 53.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    //MARK: Setup
    func setupView() {
        view.addSubview(inputsContainerView)
        inputsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 40*4).isActive = true
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1)
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        inputsContainerView.addSubview(nameSeparator)
        nameSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -16).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(mailTextField)
        mailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        mailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 0).isActive = true
        mailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1)
        mailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        inputsContainerView.addSubview(fieldSeparator)
        fieldSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        fieldSeparator.topAnchor.constraint(equalTo: mailTextField.bottomAnchor).isActive = true
        fieldSeparator.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -16).isActive = true
        fieldSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 0).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        
        inputsContainerView.addSubview(registerButton)
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        registerButton.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        view.addSubview(returnToLoginButton)
        returnToLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        returnToLoginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 0).isActive = true
        returnToLoginButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        returnToLoginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        
        view.addSubview(navigationLabel)
        navigationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        navigationLabel.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -20).isActive = true
        navigationLabel.heightAnchor.constraint(equalToConstant: 91.0).isActive = true
        navigationLabel.widthAnchor.constraint(equalToConstant: 201.0).isActive = true
        
        view.addSubview(addProfilePictureImageView)
        addProfilePictureImageView.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -5).isActive = true
        addProfilePictureImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -20).isActive = true
        addProfilePictureImageView.heightAnchor.constraint(equalToConstant: 106).isActive = true
        addProfilePictureImageView.widthAnchor.constraint(equalToConstant: 106).isActive = true
    }

}
