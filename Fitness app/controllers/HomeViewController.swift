//
//  HomeViewController.swift
//  Gym App
//
//  Created by Tinush mihiran on 2023-05-09.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background image
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "img3")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Animate the logo or any other view
        let logoImageView = UIImageView(image: UIImage(named: "logogym"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant:300)
        ])
        
        // Apply animation to the logo
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.5
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        logoImageView.layer.add(animation, forKey: "scaleAnimation")
        
        // Delay the transition to the next screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            let nextViewController = ViewController()
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
