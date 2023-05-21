//
//  RandomDetailViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-18.
//
//import UIKit
//import Firebase
//import WebKit
//
//class RandomDetailViewController: UIViewController {
//    let webView = WKWebView()
//
//    // Firebase Firestore reference
//    let db = Firestore.firestore()
//
//    // Data source for the card views
//    var exercises: [Exercisess] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        fetchRandomDocument()
//
//        // Fetch the data from Firestore
//        db.collection("RandomExercises").getDocuments() { (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                var newExercisess: [Exercisess] = []
//                for document in querySnapshot!.documents {
//                    let exercises = Exercisess(snapshot: document)
//                    newExercisess.append(exercises)
//                }
//                self.exercises = newExercisess
//                //self.addCardViews()
//                print("Fetched \(self.exercises.count) Exercisess")
//            }
//        }
//
//    }
//
//    @objc func goButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//
//
//    func fetchRandomDocument() {
//        db.collection("RandomExercises").getDocuments() { (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents found")
//                    return
//                }
//
//                let randomIndex = Int.random(in: 0..<documents.count)
//                let randomDocument = documents[randomIndex]
//
//                let randomExercise = Exercisess(snapshot: randomDocument)
//                self.displayExerciseDetails(exercise: randomExercise)
//            }
//        }
//    }
//
//    func displayExerciseDetails(exercise: Exercisess) {
//        // Clear the view
//        for subview in view.subviews {
//            subview.removeFromSuperview()
//        }
//
//
//        // Create and configure labels
//        let nameLabel = UILabel()
//        nameLabel.text = exercise.name
//        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        nameLabel.textColor = UIColor.label
//        nameLabel.numberOfLines = 0
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let exercisedifficultyLabel = UILabel()
//        exercisedifficultyLabel.text = exercise.level
//        exercisedifficultyLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        exercisedifficultyLabel.textColor = UIColor.secondaryLabel
//        exercisedifficultyLabel.numberOfLines = 0
//        exercisedifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let typeLabel = UILabel()
//        typeLabel.text = "Details: \(exercise.details)"
//        typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        typeLabel.textColor = UIColor.secondaryLabel
//        typeLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let muscleLabel = UILabel()
//        muscleLabel.text = "Days: \(exercise.days)"
//        muscleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        muscleLabel.textColor = UIColor.secondaryLabel
//        muscleLabel.numberOfLines = 0
//        muscleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        if let videoURL = URL(string: exercise.videoURL) {
//            let request = URLRequest(url: videoURL)
//            webView.load(request)
//            webView.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(webView)
//
//            NSLayoutConstraint.activate([
//                webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                webView.widthAnchor.constraint(equalToConstant: 320), // Adjust the width as needed
//                webView.heightAnchor.constraint(equalToConstant: 240) // Adjust the height as needed
//            ])
//
//
//        // Add labels to the view
//        view.addSubview(nameLabel)
//        view.addSubview(exercisedifficultyLabel)
//        view.addSubview(typeLabel)
//        view.addSubview(muscleLabel)
//
//        // Set up the labels in the view
//        NSLayoutConstraint.activate([
//            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
//            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            exercisedifficultyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
//            exercisedifficultyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            exercisedifficultyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            typeLabel.topAnchor.constraint(equalTo: exercisedifficultyLabel.bottomAnchor, constant: 16),
//            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            muscleLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
//            muscleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            muscleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
//        // Add "Go Back" button
//               let goButton = UIButton(type: .system)
//               goButton.setTitle("Go Back", for: .normal)
//               goButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//               goButton.tintColor = .white
//               goButton.backgroundColor = .systemBlue
//               goButton.layer.cornerRadius = 8
//               goButton.translatesAutoresizingMaskIntoConstraints = false
//               goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
//               view.addSubview(goButton)
//
//               NSLayoutConstraint.activate([
//                   goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                   goButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
//                   goButton.widthAnchor.constraint(equalToConstant: 120),
//                   goButton.heightAnchor.constraint(equalToConstant: 40)
//               ])
//    }
//
//
//}
//}
//

import UIKit
import Firebase
import WebKit

class RandomDetailViewController: UIViewController {
    let webView = WKWebView()

    // Firebase Firestore reference
    let db = Firestore.firestore()

    // Data source for the card views
    var exercises: [Exercisess] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchRandomDocument()

        // Fetch the data from Firestore
        db.collection("RandomExercises").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newExercisess: [Exercisess] = []
                for document in querySnapshot!.documents {
                    let exercises = Exercisess(snapshot: document)
                    newExercisess.append(exercises)
                }
                self.exercises = newExercisess
                //self.addCardViews()
                print("Fetched \(self.exercises.count) Exercisess")
            }
        }

    }

    @objc func goButtonTapped() {
        navigationController?.popViewController(animated: true)
    }


    func fetchRandomDocument() {
        db.collection("RandomExercises").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }

                let randomIndex = Int.random(in: 0..<documents.count)
                let randomDocument = documents[randomIndex]

                let randomExercise = Exercisess(snapshot: randomDocument)
                self.displayExerciseDetails(exercise: randomExercise)
            }
        }
    }

    func displayExerciseDetails(exercise: Exercisess) {
        // Clear the view
        for subview in view.subviews {
            subview.removeFromSuperview()
        }

        // Create and configure labels
        let titleLabel = UILabel()
        titleLabel.text = " \(exercise.name)"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let exercisedifficultyLabel = UILabel()
        exercisedifficultyLabel.text = "Difficulty: \(exercise.level)"
        exercisedifficultyLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        exercisedifficultyLabel.textColor = UIColor.secondaryLabel
        exercisedifficultyLabel.numberOfLines = 0
        exercisedifficultyLabel.translatesAutoresizingMaskIntoConstraints = false

        let typeLabel = UILabel()
        typeLabel.text = "Details: \(exercise.details)"
        typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        typeLabel.textColor = UIColor.secondaryLabel
        typeLabel.translatesAutoresizingMaskIntoConstraints = false

        let muscleLabel = UILabel()
        muscleLabel.text = "Days: \(exercise.days)"
        muscleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        muscleLabel.textColor = UIColor.secondaryLabel
        muscleLabel.numberOfLines = 0
        muscleLabel.translatesAutoresizingMaskIntoConstraints = false

        if let videoURL = URL(string: exercise.videoURL) {
            let request = URLRequest(url: videoURL)
            webView.load(request)
            webView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(webView)

            NSLayoutConstraint.activate([
                webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                webView.widthAnchor.constraint(equalToConstant: 320), // Adjust the width as needed
                webView.heightAnchor.constraint(equalToConstant: 240) // Adjust the height as needed
            ])
        }

        // Add labels to the view
        view.addSubview(titleLabel)
        view.addSubview(exercisedifficultyLabel)
        view.addSubview(typeLabel)
        view.addSubview(muscleLabel)

        // Set up the labels in the view
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            exercisedifficultyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            exercisedifficultyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercisedifficultyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            typeLabel.topAnchor.constraint(equalTo: exercisedifficultyLabel.bottomAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            muscleLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            muscleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            muscleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        

        // Add "Go Back" button
        let goButton = UIButton(type: .system)
        goButton.setTitle("Go Back", for: .normal)
        goButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        goButton.tintColor = .white
        goButton.backgroundColor = .black // Changed background color to black
        goButton.layer.cornerRadius = 8
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        view.addSubview(goButton)

        NSLayoutConstraint.activate([
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            goButton.widthAnchor.constraint(equalToConstant: 120),
            goButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
