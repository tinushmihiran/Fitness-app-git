//
//  HomeViewController.swift
//  Gym App
//
//  Created by Tinush mihiran on 2023-05-09.
//
//import UIKit
//import FirebaseCore
//
//class HomeViewController: UIViewController {
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    let StartBtn: UIButton = {
//        let StartBtn = UIButton(type: .system)
//        StartBtn.translatesAutoresizingMaskIntoConstraints = false
//        StartBtn.setTitleColor(.black , for: .normal)
//        StartBtn.setTitle("Get Started", for: .normal)
//        StartBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        StartBtn.backgroundColor = .white
//        StartBtn.layer.cornerRadius = 30
//        StartBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        return StartBtn
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        view.addSubview(StartBtn)
//
//
//        // Set the background image
//           let backgroundImage = UIImageView()
//           backgroundImage.image = UIImage(named: "img3")
//           backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
//           backgroundImage.clipsToBounds = true
//          backgroundImage.translatesAutoresizingMaskIntoConstraints = false
//          view.insertSubview(backgroundImage, at: 0)
//
//
//        NSLayoutConstraint.activate([
//            backgroundImage.widthAnchor.constraint(equalToConstant: 900),
//            backgroundImage.heightAnchor.constraint(equalToConstant: 800),
//            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//
//        ])
//
//
//        NSLayoutConstraint.activate([
//            StartBtn.widthAnchor.constraint(equalToConstant: 180),
//            StartBtn.heightAnchor.constraint(equalToConstant: 60),
//            StartBtn.topAnchor.constraint(equalTo: view.topAnchor,constant: 700),
//            StartBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 125)
//        ])
//
//    }
//
//    @objc func buttonTapped() {
//        let nextViewController = ViewController()
//        navigationController?.pushViewController(nextViewController, animated: true)
//    }
//
//}
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
        let logoImageView = UIImageView(image: UIImage(named: "splash"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
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
