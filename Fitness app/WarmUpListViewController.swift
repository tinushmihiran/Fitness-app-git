//
//  WarmUpListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-14.
//

import UIKit
import Firebase

    class WarmUpListViewController: UIViewController {
        
        // Firebase Firestore reference
        let db = Firestore.firestore()
        
        // Data source for the card views
        var warmupp: [WarmUp] = []
        
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
            db.collection("warmup").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    var newWarmUp: [WarmUp] = []
                    for document in querySnapshot!.documents {
                        let warmup = WarmUp(snapshot: document)
                        newWarmUp.append(warmup)
                    }
                    self.warmupp = newWarmUp
                    self.addCardViews()
                    print("Fetched \(self.warmupp.count) warmup")
                }
            }
        }
    
        @objc func goBack() {
            navigationController?.popViewController(animated: true)
           }
        
        func addCardViews() {
            var yPosition: CGFloat = 100.0
            for warmup in warmupp {
                let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: view.frame.width - 40.0, height: 200.0))
                cardView.backgroundColor = .white
                cardView.layer.cornerRadius = 10.0
                cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                cardView.layer.shadowRadius = 2.0
                cardView.layer.shadowOpacity = 0.2
            

                let nameIcon = UIImageView(image: UIImage(systemName: "circle.fill"))
                nameIcon.tintColor = .systemBlue
                nameIcon.frame = CGRect(x: 20.0, y: 25.0, width: 20.0, height: 20.0)
                cardView.addSubview(nameIcon)
                
                let nameLabel = UILabel(frame: CGRect(x: 50.0, y: 20.0, width: cardView.frame.width - 70.0, height: 30.0))
                nameLabel.text = warmup.name
                nameLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
                cardView.addSubview(nameLabel)
                
                let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
                stackView.axis = .vertical
                stackView.spacing = 5.0
                stackView.distribution = .fillEqually
                
                let descriptionLabel = UILabel()
                descriptionLabel.text = "Type: \(warmup.description)"
                descriptionLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
                stackView.addArrangedSubview(descriptionLabel)
                
                let durationLabel = UILabel()
                durationLabel.text = "duration: \(warmup.duration)"
                durationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
                stackView.addArrangedSubview(durationLabel)
                
                let repetitionsLabel = UILabel()
                repetitionsLabel.text = "repetitions:\(warmup.repetitions)"
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
            
            let warmup = warmupp[index]
            let warmupDetailViewController = WarmUpDetailViewController(name: warmup.name, WarmUpdescription: warmup.description, duration: warmup.duration, repetitions: warmup.repetitions)
            // Present the detail view controller
            navigationController?.pushViewController(warmupDetailViewController, animated: true)
        }

    }
