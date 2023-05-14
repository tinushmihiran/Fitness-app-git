//
//  ExerciseListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-10.
//

import UIKit
import Firebase

class ExerciseListViewController: UIViewController {
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    // Data source for the card views
    var exercises: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Fetch the data from Firestore
        db.collection("exercise").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newExercises: [Exercise] = []
                for document in querySnapshot!.documents {
                    let exercise = Exercise(snapshot: document)
                    newExercises.append(exercise)
                }
                self.exercises = newExercises
                self.addCardViews()
                print("Fetched \(self.exercises.count) exercises")
            }
        }
    }
    
    func addCardViews() {
        var yPosition: CGFloat = 100.0
        for exercise in exercises {
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: view.frame.width - 40.0, height: 100.0))
                  cardView.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
                  cardView.layer.cornerRadius = 10.0
                  cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                  cardView.layer.shadowRadius = 2.0
                  cardView.layer.shadowOpacity = 0.2
            
            
            let nameLabel = UILabel(frame: CGRect(x: 20.0, y: 20.0, width: cardView.frame.width - 40.0, height: 20.0))
            nameLabel.text = exercise.name
            nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            cardView.addSubview(nameLabel)
            
            let typeLabel = UILabel(frame: CGRect(x: 20.0, y: 40.0, width: cardView.frame.width - 40.0, height: 20.0))
            typeLabel.text = exercise.type
            typeLabel.font = UIFont.systemFont(ofSize: 17.0)
            cardView.addSubview(typeLabel)
            
            let muscleLabel = UILabel(frame: CGRect(x: 20.0, y: 60.0, width: cardView.frame.width - 40.0, height: 20.0))
            muscleLabel.text = exercise.muscle
            muscleLabel.font = UIFont.systemFont(ofSize: 17.0)
            cardView.addSubview(muscleLabel)
            
            let difficultyLabel = UILabel(frame: CGRect(x: 20.0, y: 80.0, width: cardView.frame.width - 40.0, height: 20.0))
            difficultyLabel.text = "Difficulty: \(exercise.difficulty)"
            difficultyLabel.font = UIFont.systemFont(ofSize: 15.0)
            cardView.addSubview(difficultyLabel)
            
            view.addSubview(cardView)
            
            yPosition += 120.0
        }
    }
}
