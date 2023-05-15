//
//  ExerciseListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-10.
//

import UIKit
import Firebase
//import FirebaseStorage

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
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: view.frame.width - 40.0, height: 200.0))
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 10.0
            cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cardView.layer.shadowRadius = 2.0
            cardView.layer.shadowOpacity = 0.2
//            
//            let exerciseImageRef = Storage.storage().reference().child(exercise.imagePath)
//                  exerciseImageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
//                      if let error = error {
//                          print("Error loading image: \(error.localizedDescription)")
//                      } else {
//                          if let imageData = data, let exerciseImage = UIImage(data: imageData) {
//                              let exerciseImageView = UIImageView(image: exerciseImage)
//                              exerciseImageView.contentMode = .scaleAspectFill
//                              exerciseImageView.clipsToBounds = true
//                              exerciseImageView.frame = CGRect(x: 0.0, y: 0.0, width: cardView.frame.width, height: 160.0)
//                              cardView.addSubview(exerciseImageView)
//                          }
//                      }
//                  }

            let exerciseIcon = UIImageView(image: UIImage(systemName: "circle.fill"))
            exerciseIcon.tintColor = .systemBlue
            exerciseIcon.frame = CGRect(x: 20.0, y: 25.0, width: 20.0, height: 20.0)
            cardView.addSubview(exerciseIcon)
            
            let nameLabel = UILabel(frame: CGRect(x: 50.0, y: 20.0, width: cardView.frame.width - 70.0, height: 30.0))
            nameLabel.text = exercise.name
            nameLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            cardView.addSubview(nameLabel)
            
            let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillEqually
            
            let typeLabel = UILabel()
            typeLabel.text = "Type: \(exercise.type)"
            typeLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(typeLabel)
            
            let muscleLabel = UILabel()
            muscleLabel.text = "Muscle: \(exercise.muscle)"
            muscleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(muscleLabel)
            
            let difficultyLabel = UILabel()
            difficultyLabel.text = "difficulty:\(exercise.difficulty)"
            difficultyLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            difficultyLabel.textAlignment = .left
            stackView.addArrangedSubview(difficultyLabel)
            
            cardView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
                stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
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
        
        // Get the index of the selected exercise
        guard let index = view.subviews.firstIndex(of: cardView) else {
            return
        }
        
        let exercise = exercises[index]
        let exerciseDetailViewController = ExerciseDetailViewController(name: exercise.name, type: exercise.type, muscle: exercise.muscle, difficulty: exercise.difficulty)
        // Present the detail view controller
        navigationController?.pushViewController(exerciseDetailViewController, animated: true)
    }
}
