//
//  MealsListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-14.
//

import UIKit
import Firebase

class MealsListViewController: UIViewController {
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    // Data source for the card views
    var foood: [Foods] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Create the "Go Back" button
        let goBackButton = UIButton(type: .system)
        goBackButton.setTitle("< Back", for: .normal)
        goBackButton.setTitleColor(.white, for: .normal)
        goBackButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false

       
        // Add the "Go Back" button to the view
               view.addSubview(goBackButton)
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            goBackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            goBackButton.widthAnchor.constraint(equalToConstant: 80),
            goBackButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        // Fetch the data from Firestore
        db.collection("foods").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newFoods: [Foods] = []
                for document in querySnapshot!.documents {
                    let foood = Foods(snapshot: document)
                    newFoods.append(foood)
                }
                self.foood = newFoods
                self.addCardViews()
                print("Fetched \(self.foood.count) food")
            }
        }
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
       }
    
    func addCardViews() {
        var yPosition: CGFloat = 100.0
        for food in foood {
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: view.frame.width - 40.0, height: 200.0))
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 10.0
            cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cardView.layer.shadowRadius = 2.0
            cardView.layer.shadowOpacity = 0.2
            
            
            let titleIcon = UIImageView(image: UIImage(systemName: "circle.fill"))
            titleIcon.tintColor = .systemBlue
            titleIcon.frame = CGRect(x: 20.0, y: 25.0, width: 20.0, height: 20.0)
            cardView.addSubview(titleIcon)
            
            let titleLabel = UILabel(frame: CGRect(x: 50.0, y: 20.0, width: cardView.frame.width - 70.0, height: 30.0))
            titleLabel.text = food.title
            titleLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            cardView.addSubview(titleLabel)
            
            let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillEqually
            
            let ingredientsLabel = UILabel()
            ingredientsLabel.text = "ingredients: \(food.ingredients)"
            ingredientsLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(ingredientsLabel)
            
            let servingsLabel = UILabel()
            servingsLabel.text = "servings: \(food.servings)"
            servingsLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(servingsLabel)
            
            let instructionsLabel = UILabel()
            instructionsLabel.text = "instructions:\(food.instructions)"
            instructionsLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            instructionsLabel.textAlignment = .left
            stackView.addArrangedSubview(instructionsLabel)
            
            cardView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
                stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
                stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10.0)
            ])
            
            let difficultyIcon = UIImageView(image: UIImage(systemName: "bolt.fill"))
            difficultyIcon.tintColor = .systemYellow
            difficultyIcon.frame = CGRect(x: cardView.frame.width - 45.0, y: 25.0, width: 20.0, height: 20.0)
            cardView.addSubview(difficultyIcon)
            
            // Add a tap gesture recognizer to the card view
              let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cardViewTapped(_:)))
              cardView.addGestureRecognizer(tapGestureRecognizer)
            
            view.addSubview(cardView)
            
            yPosition += 220.0
        }
    }
    @objc func cardViewTapped(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view else {
            return
        }
        
        // Get the index of the selected food
        guard let index = view.subviews.firstIndex(of: cardView) else {
            return
        }
        
        let food = foood[index]
        let foodDetailViewController = MealsDetailViewController(foodTitle: food.title, ingredients: food.ingredients, servings: food.servings, instructions: food.instructions)
        // Present the detail view controller
        navigationController?.pushViewController(foodDetailViewController, animated: true)
    }
}
