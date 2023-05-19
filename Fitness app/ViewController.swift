//
//  ViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-09.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Create an instance of UIImageView
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "img2")
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
        
        let RegisterLabel = UILabel()
        RegisterLabel.textColor = .white
        RegisterLabel.text = NSLocalizedString("Don't you have an account? Register here", comment: "")
        RegisterLabel.font = .systemFont(ofSize: 15)
        RegisterLabel.isUserInteractionEnabled = true
        RegisterLabel.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        RegisterLabel.addGestureRecognizer(tapGesture)
        
        view.addSubview(roundedView)
        view.addSubview(titleLabel)
        view.addSubview(Email)
        view.addSubview(Password)
        view.addSubview(LoginBtn)
        view.addSubview(RegisterLabel)
        textviewone()
        textViewTwo()
        
        LoginBtn.addTarget(self, action: #selector(buttonTapped2), for: .touchUpInside)
        
        TitleConstrains()
        
        NSLayoutConstraint.activate([
            RegisterLabel.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 60),
            RegisterLabel.topAnchor.constraint(equalTo: Password.bottomAnchor, constant: 20),
            RegisterLabel.widthAnchor.constraint(equalToConstant: 500)
        ])
        
        NSLayoutConstraint.activate([
            roundedView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            roundedView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            roundedView.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            roundedView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            LoginBtn.widthAnchor.constraint(equalToConstant: 150),
            LoginBtn.heightAnchor.constraint(equalToConstant: 45),
            LoginBtn.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            LoginBtn.topAnchor.constraint(equalTo: Password.bottomAnchor, constant: 50)
        ])
    }
    
    @objc func didTapLabel(_ gesture: UITapGestureRecognizer) {
        // Create and push a new view controller onto the navigation stack
        let newViewController = RegisterViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func buttonTapped2() {
        guard let email = Email.text, !email.isEmpty, email.contains("@"), email.contains(".") else {
            // Show an error message for an invalid email
            showErrorAlert(withMessage: "Invalid email format")
            return
        }
        
        guard let password = Password.text, !password.isEmpty else {
            // Show an error message for an empty password
            showErrorAlert(withMessage: "Password cannot be empty")
            return
        }
        
        // Use Firebase authentication to sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                // Show an error message if login fails
                strongSelf.showErrorAlert(withMessage: error.localizedDescription)
                return
            }
            // Login successful
            print("Login successful!")
            
            let nextVC = ExerciseViewController()
            strongSelf.navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    private func showErrorAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    func textviewone() {
        NSLayoutConstraint.activate([
            Email.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 65),
            Email.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 120),
            Email.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    func TitleConstrains() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 150),
            titleLabel.topAnchor.constraint(equalTo: Email.bottomAnchor, constant: -100),
            titleLabel.widthAnchor.constraint(equalToConstant: 500)
        ])
    }

    func textViewTwo() {
        NSLayoutConstraint.activate([
            Password.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 65),
            Password.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 170),
            Password.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    let roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.8
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = NSLocalizedString("Sign in", comment: "")
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let Email: UITextField = {
        let email = UITextField()
        email.textColor = .black
        email.placeholder = "Email"
        email.font = .systemFont(ofSize: 20)
        email.backgroundColor = .white
        email.borderStyle = .roundedRect
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()

    let Password: UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.placeholder = "Password"
        password.font = .systemFont(ofSize: 20)
        password.backgroundColor = .white
        password.borderStyle = .roundedRect
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()

    let LoginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white , for: .normal)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return button
    }()

}
