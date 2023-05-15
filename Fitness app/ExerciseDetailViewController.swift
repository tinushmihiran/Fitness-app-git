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
        view.backgroundColor = .white
        nameLabel.text = name
        typeLabel.text = type
        muscleLabel.text = muscle
        difficultyLabel.text = difficulty
        
        // Set up the labels in the view
        let stackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel, muscleLabel, difficultyLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
