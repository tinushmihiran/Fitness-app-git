//
//  RegisterViewController.swift
//  Gym App
//
//  Created by Tinush mihiran on 2023-05-09.
//

    import UIKit
    import Firebase
    import FirebaseAuth
    class RegisterViewController: UIViewController {
       
        override func viewDidLoad() {
            super.viewDidLoad()
         //  let auth = Auth.auth()
            view.backgroundColor = .white

            // Create an instance of UIImageView
               let backgroundImageViewRegister = UIImageView(frame: self.view.bounds)
            backgroundImageViewRegister.image = UIImage(named: "img2")
            backgroundImageViewRegister.contentMode = .scaleAspectFill
               self.view.addSubview(backgroundImageViewRegister)
               self.view.sendSubviewToBack(backgroundImageViewRegister)
            
            
            let LoginLabel = UILabel()
            LoginLabel.textColor = .white
            LoginLabel.text = NSLocalizedString("Already Have an Account? Click here", comment: "")
            LoginLabel.font = .systemFont(ofSize: 15)
            LoginLabel.isUserInteractionEnabled = true
            LoginLabel.translatesAutoresizingMaskIntoConstraints = false
            let tapGestureRegister = UITapGestureRecognizer(target: self, action: #selector(didTapLabelRegister(_:)))
            LoginLabel.addGestureRecognizer(tapGestureRegister)
           
            view.addSubview(roundedViewRegister)
            view.addSubview(TitleRegister)
            view.addSubview(RegisterEmail)
            view.addSubview(RegisterPassword)
            view.addSubview(RegisterBtn)
            view.addSubview(LoginLabel)
          //  RegisterLabelConstrains()
            RegisterEmailConstrains()
            RegisterPasswordConstrains()
            RegisterBtn.addTarget(self, action: #selector(buttonTapped3), for: .touchUpInside)
            
            
            TitleConstrainsRegister()
            
            NSLayoutConstraint.activate([
                LoginLabel.leftAnchor.constraint(equalTo: roundedViewRegister.leftAnchor, constant: 60),
                LoginLabel.topAnchor.constraint(equalTo: RegisterPassword.bottomAnchor, constant: 20),
    //                       titleLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
                LoginLabel.widthAnchor.constraint(equalToConstant: 500 )
         

            ])
            
            NSLayoutConstraint.activate([
                roundedViewRegister.widthAnchor
                           .constraint(equalTo: view.widthAnchor,
                                       multiplier: 0.9),
                roundedViewRegister.heightAnchor
                           .constraint(equalTo: view.heightAnchor,
                                       multiplier: 0.4),
                roundedViewRegister.topAnchor
                           .constraint(equalTo: view.topAnchor,constant: 230),
                roundedViewRegister.leftAnchor
                           .constraint(equalTo: view.leftAnchor,constant: 20),
                   ])
                   
            NSLayoutConstraint.activate([
                RegisterBtn.widthAnchor.constraint(equalToConstant: 150),
                RegisterBtn.heightAnchor.constraint(equalToConstant: 45),
                RegisterBtn.centerXAnchor.constraint(equalTo: roundedViewRegister.centerXAnchor),
                RegisterBtn.topAnchor.constraint(equalTo: RegisterPassword.bottomAnchor, constant: 50)
            ])
            
            // Add tap gesture recognizer to dismiss the keyboard
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                    view.addGestureRecognizer(tapGesture)
            
        }
        
        @objc func dismissKeyboard() {
                view.endEditing(true)
            }
        
        @objc func didTapLabelRegister(_ gesture: UITapGestureRecognizer) {
                // Create and push a new view controller onto the navigation stack
                let newViewController = ViewController()
                navigationController?.pushViewController(newViewController, animated: true)
            }
        

        @objc func buttonTapped3() {
            guard let email = RegisterEmail.text, !email.isEmpty, email.contains("@"), email.contains(".") else {
                // Show an error message for an invalid email
                showErrorAlertRegister(withMessage: "Invalid email format")
                return
            }
            
            guard let password = RegisterPassword.text, !password.isEmpty else {
                // Show an error message for an empty password
                showErrorAlertRegister(withMessage: "Password cannot be empty")
                return
            }
            
            // Use Firebase authentication to register in the user
            Firebase.Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
                guard let strongSelf = self else { return }
                if error != nil {
                    // Show an error message if user registration failed
                    strongSelf.showErrorAlertRegister(withMessage: "User registration failed")
                } else {
                    // User registration successful
                    print("User registration successful")
                    strongSelf.showErrorAlertRegister(withMessage: "User registration successful")
                    let nextVC = WelcomeViewController()
                    strongSelf.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
        }
        
        private func showErrorAlertRegister(withMessage message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }

        let RegisterBtn : UIButton = {
            let RegisterBtn = UIButton(type: .system)
            RegisterBtn.translatesAutoresizingMaskIntoConstraints = false
            RegisterBtn.setTitleColor(.white , for: .normal)
            RegisterBtn.setTitle("Register", for: .normal)
            RegisterBtn.backgroundColor = .black
            RegisterBtn.layer.cornerRadius = 25
            RegisterBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            RegisterBtn.addTarget(self, action: #selector(buttonTapped3), for: .touchUpInside)
            return RegisterBtn
        }()
        
        

     
      
    }


    func RegisterEmailConstrains(){
        NSLayoutConstraint.activate([
            RegisterEmail.leftAnchor
            .constraint(equalTo: roundedViewRegister.leftAnchor,
                        constant: 65),
            RegisterEmail.topAnchor
            .constraint(equalTo: roundedViewRegister.topAnchor,
                        constant: 120),
            RegisterEmail.widthAnchor.constraint(equalToConstant: 250)
        
    ])
      
    }
    func TitleConstrainsRegister() {
                   NSLayoutConstraint.activate([
                    TitleRegister.leftAnchor.constraint(equalTo: roundedViewRegister.leftAnchor, constant: 150),
                    TitleRegister.topAnchor.constraint(equalTo: RegisterEmail.bottomAnchor, constant: -100),
    //                       titleLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
                    TitleRegister.widthAnchor.constraint(equalToConstant: 500 )
                

                   ])
    }




    func RegisterPasswordConstrains(){
        NSLayoutConstraint.activate([
            RegisterPassword.leftAnchor
                    .constraint(equalTo: roundedViewRegister.leftAnchor,
                                constant: 65),
            RegisterPassword.topAnchor
                    .constraint(equalTo: roundedViewRegister.topAnchor,
                                constant: 170),
            RegisterPassword.widthAnchor.constraint(equalToConstant: 250)
        
    ])
        
    }
        

        let roundedViewRegister: UIView = {
            
            let view = UIView()
            view.layer.cornerRadius = 30
            view.backgroundColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            view.alpha = 0.8
            return view
        }()
        
        let TitleRegister: UILabel = {
            let TitleRegister = UILabel()
            TitleRegister.textColor = .white
            TitleRegister.text = NSLocalizedString("Register", comment: "")
            TitleRegister.font = .systemFont(ofSize: 30)
            TitleRegister.translatesAutoresizingMaskIntoConstraints = false
            return TitleRegister
        }()






    let RegisterEmail: UITextField = {
        let RegisterEmail = UITextField()
        RegisterEmail.textColor = .black
        RegisterEmail.placeholder = "Email"
        RegisterEmail.font = .systemFont(ofSize: 20)
        RegisterEmail.backgroundColor = .white
        RegisterEmail.borderStyle = .roundedRect
     
        RegisterEmail.translatesAutoresizingMaskIntoConstraints = false
        return RegisterEmail
    }()

    let RegisterPassword: UITextField = {
        let RegisterPassword = UITextField()
        RegisterPassword.textColor = .black
        RegisterPassword.placeholder = "Password"
        RegisterPassword.font = .systemFont(ofSize: 20)
        RegisterPassword.backgroundColor = .white
        RegisterPassword.borderStyle = .roundedRect
        
        RegisterPassword.translatesAutoresizingMaskIntoConstraints = false
        return RegisterPassword
    }()



