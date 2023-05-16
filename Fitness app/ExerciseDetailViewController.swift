//
//  ExerciseDetailViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-15.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    
    var name: String
    var type: String
    var muscle: String
    var difficulty: String
    
    let nameLabel = UILabel()
    let typeLabel = UILabel()
    let muscleLabel = UILabel()
    let difficultyLabel = UILabel()
    let goBackButton = UIButton()
    
    init(name: String, type: String, muscle: String, difficulty: String) {
        self.name = name
        self.type = type
        self.muscle = muscle
        self.difficulty = difficulty
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
        
        typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        typeLabel.textColor = UIColor.secondaryLabel
        
        muscleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        muscleLabel.textColor = UIColor.secondaryLabel
        
        difficultyLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        difficultyLabel.textColor = UIColor.secondaryLabel
        
        // Set label text
        nameLabel.text = name
        typeLabel.text = "Type: \(type)"
        muscleLabel.text = "Muscle: \(muscle)"
        difficultyLabel.text = "Difficulty: \(difficulty)"
        
        // Set up the labels in the view
        let stackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel, muscleLabel, difficultyLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
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
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(goBackButton)
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
        @objc func goBack() {
            navigationController?.popViewController(animated: true)
        }
    
}
