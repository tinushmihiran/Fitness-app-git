//
//  WarmUpDetailViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-16.
//

import UIKit

class WarmUpDetailViewController: UIViewController {
    
    var name: String
    var WarmUpdescription: String
    var duration: String
    var repetitions: String
    
    let nameLabel = UILabel()
    let WarmUpdescriptionLabel = UILabel()
    let durationLabel = UILabel()
    let repetitionsLabel = UILabel()
    let goBackButton = UIButton()
    
    init(name: String, WarmUpdescription: String, duration: String, repetitions: String) {
        self.name = name
        self.WarmUpdescription = WarmUpdescription
        self.duration = duration
        self.repetitions = repetitions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up view background color
        view.backgroundColor = UIColor.systemBackground
        
        // Set up label styles
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.textColor = UIColor.label
        nameLabel.numberOfLines = 0
        
        WarmUpdescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        WarmUpdescriptionLabel.textColor = UIColor.secondaryLabel
        WarmUpdescriptionLabel.numberOfLines = 0
        
        durationLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        durationLabel.textColor = UIColor.secondaryLabel
        
        repetitionsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        repetitionsLabel.textColor = UIColor.secondaryLabel
        repetitionsLabel.numberOfLines = 0
        
        // Set label text
        nameLabel.text =  name
        WarmUpdescriptionLabel.text = " WarmUpdescription:\n\( WarmUpdescription)"
        durationLabel.text = " duration: \( duration)"
        repetitionsLabel.text = " repetitions:\n\( repetitions)"
        
        // Set up the labels in the view
        let stackView = UIStackView(arrangedSubviews: [nameLabel, WarmUpdescriptionLabel, durationLabel, repetitionsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Set up the "Go Back" button
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.setTitleColor(UIColor.systemBlue, for: .normal)
        goBackButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        goBackButton.layer.cornerRadius = 8
        goBackButton.layer.borderWidth = 2
        goBackButton.layer.borderColor = UIColor.systemBlue.cgColor
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(goBackButton)
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goBackButton.widthAnchor.constraint(equalToConstant: 120),
            goBackButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
