//
//  WelcomeViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-17.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - Properties
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupWelcomeLabel()
        setupNextButton()
        
        animateWelcomeLabel()
        animateNextButton()
    }
    
    // MARK: - Setup Methods
    
    func setupWelcomeLabel() {
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Animation Methods
    
    func animateWelcomeLabel() {
        welcomeLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        welcomeLabel.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.welcomeLabel.transform = .identity
            self.welcomeLabel.alpha = 1.0
        }, completion: nil)
    }
    
    func animateNextButton() {
        nextButton.transform = CGAffineTransform(translationX: 0, y: 50)
        nextButton.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations: {
            self.nextButton.transform = .identity
            self.nextButton.alpha = 1.0
        }, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func nextButtonTapped() {
        let exerciseViewController = ProfileDetailGetViewController()
        navigationController?.pushViewController(exerciseViewController, animated: true)
    }
}
