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
    var food: [Foods] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Fetch the data from Firestore
        db.collection("foods").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newFoods: [Foods] = []
                for document in querySnapshot!.documents {
                    let food = Foods(snapshot: document)
                    newFoods.append(food)
                }
                self.food = newFoods
                self.addCardViews()
                print("Fetched \(self.food.count) food")
            }
        }
    }
    
    func addCardViews() {
        var yPosition: CGFloat = 100.0
        for food in food {
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: view.frame.width - 40.0, height: 100.0))
                  cardView.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
                  cardView.layer.cornerRadius = 10.0
                  cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                  cardView.layer.shadowRadius = 2.0
                  cardView.layer.shadowOpacity = 0.2
            
            
            let titleLabel = UILabel(frame: CGRect(x: 20.0, y: 20.0, width: cardView.frame.width - 40.0, height: 20.0))
            titleLabel.text = food.title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            cardView.addSubview(titleLabel)
            
            let ingredientsLabel = UILabel(frame: CGRect(x: 20.0, y: 40.0, width: cardView.frame.width - 40.0, height: 20.0))
            ingredientsLabel.text = food.ingredients
            ingredientsLabel.font = UIFont.systemFont(ofSize: 17.0)
            cardView.addSubview(ingredientsLabel)
            
            let servingsLabel = UILabel(frame: CGRect(x: 20.0, y: 60.0, width: cardView.frame.width - 40.0, height: 20.0))
            servingsLabel.text = food.servings
            servingsLabel.font = UIFont.systemFont(ofSize: 17.0)
            cardView.addSubview(servingsLabel)
            
            let instructionsLabel = UILabel(frame: CGRect(x: 20.0, y: 80.0, width: cardView.frame.width - 40.0, height: 20.0))
            instructionsLabel.text = "instructions: \(food.instructions)"
            instructionsLabel.font = UIFont.systemFont(ofSize: 15.0)
            cardView.addSubview(instructionsLabel)
            
            view.addSubview(cardView)
            
            yPosition += 120.0
        }
    }
}
