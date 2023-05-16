//
//  MealsDetailViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-16.
//

import UIKit

class MealsDetailViewController: UIViewController {

    var foodTitle: String
    var ingredients: String
    var servings: String
    var instructions: String
    
    let titleLabel = UILabel()
    let ingredientsLabel = UILabel()
    let servingsLabel = UILabel()
    let instructionsLabel = UILabel()
    let goBackButton = UIButton()
    
    init(foodTitle: String, ingredients: String, servings: String, instructions: String) {
        self.foodTitle = foodTitle
        self.ingredients = ingredients
        self.servings = servings
        self.instructions = instructions
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
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 0
        
        ingredientsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        ingredientsLabel.textColor = UIColor.secondaryLabel
        ingredientsLabel.numberOfLines = 0
        
        servingsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        servingsLabel.textColor = UIColor.secondaryLabel
        
        instructionsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        instructionsLabel.textColor = UIColor.secondaryLabel
        instructionsLabel.numberOfLines = 0
        
        // Set label text
        titleLabel.text =  foodTitle
        ingredientsLabel.text = "Ingredients:\n\(ingredients)"
        servingsLabel.text = "Servings: \(servings)"
        instructionsLabel.text = "Instructions:\n\(instructions)"
        
        // Set up the labels in the view
        let stackView = UIStackView(arrangedSubviews: [titleLabel, ingredientsLabel, servingsLabel, instructionsLabel])
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
