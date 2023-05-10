//
//  HomeViewController.swift
//  Gym App
//
//  Created by Tinush mihiran on 2023-05-09.
//
import UIKit
import FirebaseCore

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    let StartBtn: UIButton = {
        let StartBtn = UIButton(type: .system)
        StartBtn.translatesAutoresizingMaskIntoConstraints = false
        StartBtn.setTitleColor(.black , for: .normal)
        StartBtn.setTitle("Get Started", for: .normal)
        StartBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        StartBtn.backgroundColor = .white
        StartBtn.layer.cornerRadius = 30
        StartBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return StartBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        view.addSubview(StartBtn)
            
        
        // Set the background image
           let backgroundImage = UIImageView()
           backgroundImage.image = UIImage(named: "img3")
           backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
           backgroundImage.clipsToBounds = true
          backgroundImage.translatesAutoresizingMaskIntoConstraints = false
          view.insertSubview(backgroundImage, at: 0)
          
            
        NSLayoutConstraint.activate([
            backgroundImage.widthAnchor.constraint(equalToConstant: 900),
            backgroundImage.heightAnchor.constraint(equalToConstant: 800),
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
 
        
        NSLayoutConstraint.activate([
            StartBtn.widthAnchor.constraint(equalToConstant: 180),
            StartBtn.heightAnchor.constraint(equalToConstant: 60),
            StartBtn.topAnchor.constraint(equalTo: view.topAnchor,constant: 700),
            StartBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 125)
        ])
        
    }

    @objc func buttonTapped() {
        let nextViewController = ViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}

