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
        var warmup: [WarmUp] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black
            
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
                    self.warmup = newWarmUp
                    self.addCardViews()
                    print("Fetched \(self.warmup.count) warmup")
                }
            }
        }
        
        func addCardViews() {
            var yPosition: CGFloat = 100.0
            for warmup in warmup {
                let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: view.frame.width - 40.0, height: 100.0))
                      cardView.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
                      cardView.layer.cornerRadius = 10.0
                      cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                      cardView.layer.shadowRadius = 2.0
                      cardView.layer.shadowOpacity = 0.2
                
                
                let nameLabel = UILabel(frame: CGRect(x: 20.0, y: 20.0, width: cardView.frame.width - 40.0, height: 20.0))
                nameLabel.text = warmup.name
                nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
                cardView.addSubview(nameLabel)
                
                let descriptionLabel = UILabel(frame: CGRect(x: 20.0, y: 40.0, width: cardView.frame.width - 40.0, height: 20.0))
                descriptionLabel.text = warmup.description
                descriptionLabel.font = UIFont.systemFont(ofSize: 17.0)
                cardView.addSubview(descriptionLabel)
                
                let durationLabel = UILabel(frame: CGRect(x: 20.0, y: 60.0, width: cardView.frame.width - 40.0, height: 20.0))
                durationLabel.text = warmup.duration
                durationLabel.font = UIFont.systemFont(ofSize: 17.0)
                cardView.addSubview(durationLabel)
                
                let repetitionsLabel = UILabel(frame: CGRect(x: 20.0, y: 80.0, width: cardView.frame.width - 40.0, height: 20.0))
                repetitionsLabel.text = "repetitions: \(warmup.repetitions)"
                repetitionsLabel.font = UIFont.systemFont(ofSize: 15.0)
                cardView.addSubview(repetitionsLabel)
                
                view.addSubview(cardView)
                
                yPosition += 120.0
            }
        }
    }
