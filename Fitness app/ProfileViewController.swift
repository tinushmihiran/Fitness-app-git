//
//  ProfileViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-17.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Add "Go Back" button
           let goBackButton = UIButton(type: .system)
           goBackButton.translatesAutoresizingMaskIntoConstraints = false
           goBackButton.setTitle("Go Back", for: .normal)
           goBackButton.backgroundColor = .white
           goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
           view.addSubview(goBackButton)
        
        NSLayoutConstraint.activate([
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goBackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goBackButton.widthAnchor.constraint(equalToConstant: 100),
            goBackButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func goBackButtonTapped() {
      
        navigationController?.popViewController(animated: true)
   
    }
}
