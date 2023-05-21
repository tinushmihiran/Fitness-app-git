//
//  AddedExerciseViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-20.
//


    import UIKit
    import Firebase
  

    class AddedExerciseViewController: UIViewController {
        
        // Firebase Firestore reference
        let db = Firestore.firestore()
        
        // Data source for the card views
        var exercises: [Schedule] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            
            // Fetch the data from Firestore
            db.collection("AddSchedule").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    var newSchedule: [Schedule] = []
                    for document in querySnapshot!.documents {
                        let exercises = Schedule(snapshot: document)
                        newSchedule.append(exercises)
                    }
                    self.exercises = newSchedule
                    self.addCardViews()
                    print("Fetched \(self.exercises.count) Schedule")
                }
            }
            
            // Add background image to the view
                    let backgroundImage = UIImageView(frame: view.bounds)
                    backgroundImage.image = UIImage(named: "RoundViewOne")
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
            let selectedSchedule = exercises[index]
            
            let cardDetailsVC = ScheduleDetailsViewController(exercise: selectedSchedule)
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
               titleLabel.text = "All Schedules"
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
            
            for (index, Schedule) in exercises.enumerated() {
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
                nameLabel.text = Schedule.name
                nameLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
                cardView.addSubview(nameLabel)
                
                let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
                stackView.axis = .vertical
                stackView.spacing = 5.0
                stackView.distribution = .fillEqually
                
                let exercisedescriptionLabel = UILabel()
                exercisedescriptionLabel.text = "Description: \(Schedule.description)"
                exercisedescriptionLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
                stackView.addArrangedSubview(exercisedescriptionLabel)
                
                let durationLabel = UILabel()
                durationLabel.text = "Muscle: \(Schedule.muscle)"
                durationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
                stackView.addArrangedSubview(durationLabel)
                
                let repetitionsLabel = UILabel()
                repetitionsLabel.text = "Days:\(Schedule.days)"
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


    class ScheduleDetailsViewController: UIViewController {
        
        let Schedule: Schedule
        let goBackButton = UIButton()
       
        
        init(exercise: Schedule) {
            self.Schedule = exercise
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            // Create and configure the background image view
                    let backgroundImage = UIImageView(image: UIImage(named: "exebg"))
                    backgroundImage.contentMode = .scaleAspectFill
                    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(backgroundImage)
            NSLayoutConstraint.activate([
                        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
                        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                    ])
            // Create and configure labels
            let nameLabel = UILabel()
            nameLabel.text = Schedule.name
            nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
            nameLabel.textColor = UIColor.label
            nameLabel.numberOfLines = 0
            
                   let exercisedifficultyLabel = UILabel()
            exercisedifficultyLabel.text = "Description: \(Schedule.description) "
            exercisedifficultyLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            exercisedifficultyLabel.textColor = UIColor.secondaryLabel
            exercisedifficultyLabel.numberOfLines = 0
                   
                   let typeLabel = UILabel()
            typeLabel.text = "Muscle: \(Schedule.muscle) seconds"
            typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            typeLabel.textColor = UIColor.secondaryLabel
                   
                   let muscleLabel = UILabel()
            muscleLabel.text = "Days: \(Schedule.days)"
            muscleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            muscleLabel.textColor = UIColor.secondaryLabel
            muscleLabel.numberOfLines = 0
            
            
                   // Add labels to the view
                   view.addSubview(nameLabel)
                   view.addSubview(exercisedifficultyLabel)
                   view.addSubview(typeLabel)
                   view.addSubview(muscleLabel)
                    

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
            goBackButton.setTitleColor(UIColor.white, for: .normal)
            goBackButton.backgroundColor = UIColor.black
            goBackButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            goBackButton.layer.cornerRadius = 8
            goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            goBackButton.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(goBackButton)
            
            NSLayoutConstraint.activate([
                goBackButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        }
        
        @objc func goBack() {
            navigationController?.popViewController(animated: true)
        }
    }
