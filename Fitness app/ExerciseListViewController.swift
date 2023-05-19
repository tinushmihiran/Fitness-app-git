//
//  ExerciseListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-10.
//

import UIKit
import Firebase
import WebKit

class ExerciseListViewController: UIViewController {
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    // Data source for the card views
    var exercises: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Fetch the data from Firestore
        db.collection("exercise").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newExercise: [Exercise] = []
                for document in querySnapshot!.documents {
                    let exercises = Exercise(snapshot: document)
                    newExercise.append(exercises)
                }
                self.exercises = newExercise
                self.addCardViews()
                print("Fetched \(self.exercises.count) Exercise")
            }
        }
        
        // Add background image to the view
                let backgroundImage = UIImageView(frame: view.bounds)
                backgroundImage.image = UIImage(named: "RoundViewOne") // Replace "your-background-image" with the actual image name
                backgroundImage.contentMode = .scaleAspectFill
                view.addSubview(backgroundImage)
                view.sendSubviewToBack(backgroundImage)
    }
    
    @objc func goButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view else { return }
        guard let index = cardView.tag as Int? else { return }
        let selectedexercise = exercises[index]
        
        let cardDetailsVC = ExerciseDetailsViewController(exercise: selectedexercise)
        navigationController?.pushViewController(cardDetailsVC, animated: true)
    }
    
    func addCardViews() {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        
      
        
        var yPosition: CGFloat = 100.0
        let contentWidth = view.frame.width - 40.0
        
        // Create a title label
           let titleLabel = UILabel(frame: CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 30.0))
           titleLabel.text = "All Exercises"
           titleLabel.textColor = .white
           titleLabel.font = UIFont.systemFont(ofSize: 34.0, weight: .bold)
           scrollView.addSubview(titleLabel)
           yPosition += 50.0
        
        // Create a "Go" button
          let goButton = UIButton(type: .system)
          goButton.setTitle("Go back", for: .normal)
          goButton.setTitleColor(.white, for: .normal)
          goButton.backgroundColor = .systemBlue
          goButton.layer.cornerRadius = 10.0
          goButton.frame = CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 50.0)
          goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
          scrollView.addSubview(goButton)
          yPosition += 70.0
        
        for (index, exercises) in exercises.enumerated() {
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 200.0))
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 10.0
            cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cardView.layer.shadowRadius = 2.0
            cardView.layer.shadowOpacity = 0.2
            
            let titleIcon = UIImageView(image: UIImage(systemName: "circle.fill"))
            titleIcon.tintColor = .systemBlue
            titleIcon.frame = CGRect(x: 20.0, y: 25.0, width: 20.0, height: 20.0)
            cardView.addSubview(titleIcon)
            
            let nameLabel = UILabel(frame: CGRect(x: 50.0, y: 20.0, width: cardView.frame.width - 70.0, height: 30.0))
            nameLabel.text = exercises.name
            nameLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            cardView.addSubview(nameLabel)
            
            let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillEqually
            
            let exercisedescriptionLabel = UILabel()
            exercisedescriptionLabel.text = "exercisedifficulty: \(exercises.exercisedifficulty)"
            exercisedescriptionLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(exercisedescriptionLabel)
            
            let durationLabel = UILabel()
            durationLabel.text = "type: \(exercises.type)"
            durationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(durationLabel)
            
            let repetitionsLabel = UILabel()
            repetitionsLabel.text = "muscle:\(exercises.muscle)"
            repetitionsLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            repetitionsLabel.textAlignment = .left
            stackView.addArrangedSubview(repetitionsLabel)
            
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
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
            cardView.addGestureRecognizer(tapGesture)
            cardView.isUserInteractionEnabled = true
            cardView.tag = index
            
            scrollView.addSubview(cardView)
            
            yPosition += 220.0
        }
        
        // Set the content size of the scroll view
        let contentHeight = yPosition + 20.0
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Add the scroll view to the main view
        view.addSubview(scrollView)
    }
}


class ExerciseDetailsViewController: UIViewController {
    
    let exercise: Exercise
    let goBackButton = UIButton()
    let webView = WKWebView()
    
    init(exercise: Exercise) {
        self.exercise = exercise
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Create and configure labels
               let nameLabel = UILabel()
               nameLabel.text = exercise.name
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.textColor = UIColor.label
        nameLabel.numberOfLines = 0
               let exercisedifficultyLabel = UILabel()
        exercisedifficultyLabel.text = exercise.exercisedifficulty
        exercisedifficultyLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        exercisedifficultyLabel.textColor = UIColor.secondaryLabel
        exercisedifficultyLabel.numberOfLines = 0
               
               let typeLabel = UILabel()
        typeLabel.text = "Duration: \(exercise.type) seconds"
        typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        typeLabel.textColor = UIColor.secondaryLabel
               
               let muscleLabel = UILabel()
        muscleLabel.text = "Repetitions: \(exercise.muscle)"
        muscleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        muscleLabel.textColor = UIColor.secondaryLabel
        muscleLabel.numberOfLines = 0
        
//        // Set up the WKWebView
//             let videoURL = URL(string: "https://youtu.be/iSSAk4XCsRA")
//             let request = URLRequest(url: videoURL!)
//             webView.load(request)
//             webView.translatesAutoresizingMaskIntoConstraints = false
//             view.addSubview(webView)
//
//             NSLayoutConstraint.activate([
//                 webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                 webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                 webView.widthAnchor.constraint(equalToConstant: 320), // Adjust the width as needed
//                 webView.heightAnchor.constraint(equalToConstant: 240) // Adjust the height as needed
//             ])
        
        // Set up the WKWebView
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
               view.addSubview(nameLabel)
               view.addSubview(exercisedifficultyLabel)
               view.addSubview(typeLabel)
               view.addSubview(muscleLabel)
                //view.addSubview(webView)

        // Set up the labels in the view
        let stackView = UIStackView(arrangedSubviews: [nameLabel, exercisedifficultyLabel, typeLabel, muscleLabel])
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
            goBackButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
