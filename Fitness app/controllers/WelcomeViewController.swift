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
        label.font = UIFont.boldSystemFont(ofSize: 44)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Add background image to the view
                let backgroundImage = UIImageView(frame: view.bounds)
                backgroundImage.image = UIImage(named: "exerciseback")
                backgroundImage.contentMode = .scaleAspectFill
                view.addSubview(backgroundImage)
                view.sendSubviewToBack(backgroundImage)
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
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 80)
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
