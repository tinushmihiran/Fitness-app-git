//
//  ActivityDetailViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-16.
//

import UIKit
import CoreMotion
import CoreLocation
import Firebase

class ActivityDetailViewController: UIViewController, CLLocationManagerDelegate {

    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    let activityQueue = OperationQueue()
    let locationManager = CLLocationManager()
    
    lazy var activityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Activity:"
        return label
    }()

    lazy var activityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()

    lazy var stepsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Steps:"
        return label
    }()

    lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()

    lazy var distanceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Distance:"
        return label
    }()

    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()

    lazy var caloriesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Calories Burned:"
        return label
    }()

    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()

    lazy var activityImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         imageView.image = UIImage(named: "activity_icon")
         return imageView
     }()

     lazy var stepsImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         imageView.image = UIImage(named: "footsteps")
         return imageView
     }()

     lazy var distanceImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         imageView.image = UIImage(named: "distance")
         return imageView
     }()

     lazy var caloriesImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         imageView.image = UIImage(named: "kcal")
         return imageView
     }()
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadActivityResults()
        }

        private func loadActivityResults() {
            let db = Firestore.firestore()

            let stepsCountDocument = db.collection("activity").document("stepsCount")
            stepsCountDocument.getDocument { [weak self] (document, error) in
                if let document = document, document.exists {
                    if let count = document.data()?["count"] as? Int {
                        self?.stepsLabel.text = "\(count)"
                    }
                }
            }

            let distanceDocument = db.collection("activity").document("distance")
            distanceDocument.getDocument { [weak self] (document, error) in
                if let document = document, document.exists {
                    if let value = document.data()?["value"] as? Double {
                        let kilometers = value / 1000.0
                        self?.distanceLabel.text = String(format: "%.2f km", kilometers)
                    }
                }
            }

            let caloriesDocument = db.collection("activity").document("calories")
            caloriesDocument.getDocument { [weak self] (document, error) in
                if let document = document, document.exists {
                    if let value = document.data()?["value"] as? Double {
                        self?.caloriesLabel.text = String(format: "%.2f", value)
                    }
                }
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Add "Go Back" button
           let goBackButton = UIButton(type: .system)
           goBackButton.translatesAutoresizingMaskIntoConstraints = false
           goBackButton.setTitle("Go Back", for: .normal)
           goBackButton.backgroundColor = .white
           goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
           view.addSubview(goBackButton)
           
           NSLayoutConstraint.activate([
               goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               goBackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               goBackButton.widthAnchor.constraint(equalToConstant: 100),
               goBackButton.heightAnchor.constraint(equalToConstant: 40)
           ])
        
        // Set the background image
          let backgroundImage = UIImage(named: "analyzeBG")
          let backgroundImageView = UIImageView(image: backgroundImage)
          backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
          backgroundImageView.contentMode = .scaleAspectFill
          view.addSubview(backgroundImageView)
          view.sendSubviewToBack(backgroundImageView)

          NSLayoutConstraint.activate([
              backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
              backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
        
        setupLabels()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        if CMMotionActivityManager.isActivityAvailable() {
            activityManager.startActivityUpdates(to: activityQueue) { [weak self] (activity: CMMotionActivity?) in
                DispatchQueue.main.async {
                    self?.handleActivityUpdate(activity)
                }
            }
        }

        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] (pedometerData: CMPedometerData?, error: Error?) in
                DispatchQueue.main.async {
                    self?.handlePedometerUpdate(pedometerData, error)
                }
            }
        }
        
       
        
    }
    @objc private func goBackButtonTapped() {
           // Dismiss the current view controller
        navigationController?.popViewController(animated: true)
       }
    
    private func setupLabels() {
           view.addSubview(activityImageView)
           view.addSubview(activityTitleLabel)
           view.addSubview(activityLabel)
           view.addSubview(stepsImageView)
           view.addSubview(stepsTitleLabel)
           view.addSubview(stepsLabel)
           view.addSubview(distanceImageView)
           view.addSubview(distanceTitleLabel)
           view.addSubview(distanceLabel)
           view.addSubview(caloriesImageView)
           view.addSubview(caloriesTitleLabel)
           view.addSubview(caloriesLabel)

           NSLayoutConstraint.activate([
               activityImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               activityImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               activityImageView.widthAnchor.constraint(equalToConstant: 24),
               activityImageView.heightAnchor.constraint(equalToConstant: 24),

               activityTitleLabel.centerYAnchor.constraint(equalTo: activityImageView.centerYAnchor),
               activityTitleLabel.leadingAnchor.constraint(equalTo: activityImageView.trailingAnchor, constant: 8),

               activityLabel.topAnchor.constraint(equalTo: activityTitleLabel.topAnchor),
               activityLabel.leadingAnchor.constraint(equalTo: activityTitleLabel.trailingAnchor, constant: 8),
               activityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

               stepsImageView.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 36),
               stepsImageView.leadingAnchor.constraint(equalTo: activityImageView.leadingAnchor),
               stepsImageView.widthAnchor.constraint(equalToConstant: 24),
               stepsImageView.heightAnchor.constraint(equalToConstant: 24),

               stepsTitleLabel.centerYAnchor.constraint(equalTo: stepsImageView.centerYAnchor),
               stepsTitleLabel.leadingAnchor.constraint(equalTo: stepsImageView.trailingAnchor, constant: 28),

               stepsLabel.topAnchor.constraint(equalTo: stepsTitleLabel.topAnchor),
               stepsLabel.leadingAnchor.constraint(equalTo: activityLabel.leadingAnchor),
               stepsLabel.trailingAnchor.constraint(equalTo: activityLabel.trailingAnchor),

               distanceImageView.topAnchor.constraint(equalTo: stepsTitleLabel.bottomAnchor, constant: 28),
               distanceImageView.leadingAnchor.constraint(equalTo: stepsImageView.leadingAnchor),
               distanceImageView.widthAnchor.constraint(equalToConstant: 24),
               distanceImageView.heightAnchor.constraint(equalToConstant: 24),

               distanceTitleLabel.centerYAnchor.constraint(equalTo: distanceImageView.centerYAnchor),
               distanceTitleLabel.leadingAnchor.constraint(equalTo: distanceImageView.trailingAnchor, constant: 28),

               distanceLabel.topAnchor.constraint(equalTo: distanceTitleLabel.topAnchor),
               distanceLabel.leadingAnchor.constraint(equalTo: stepsLabel.leadingAnchor),
               distanceLabel.trailingAnchor.constraint(equalTo: stepsLabel.trailingAnchor),

               caloriesImageView.topAnchor.constraint(equalTo: distanceTitleLabel.bottomAnchor, constant: 28),
               caloriesImageView.leadingAnchor.constraint(equalTo: distanceImageView.leadingAnchor),
               caloriesImageView.widthAnchor.constraint(equalToConstant: 24),
               caloriesImageView.heightAnchor.constraint(equalToConstant: 24),

               caloriesTitleLabel.centerYAnchor.constraint(equalTo: caloriesImageView.centerYAnchor),
               caloriesTitleLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 28),

               caloriesLabel.topAnchor.constraint(equalTo: caloriesTitleLabel.topAnchor),
               caloriesLabel.leadingAnchor.constraint(equalTo: distanceLabel.leadingAnchor),
               caloriesLabel.trailingAnchor.constraint(equalTo: distanceLabel.trailingAnchor),
           ])
       }

        private func handleActivityUpdate(_ activity: CMMotionActivity?) {
            guard let activity = activity else { return }

            if activity.running {
                activityLabel.text = "Running"
            } else if activity.walking {
                activityLabel.text = "Walking"
            } else if activity.automotive {
                activityLabel.text = "Automotive"
            } else if activity.stationary {
                activityLabel.text = "Stationary"
            }
        }

    private func handlePedometerUpdate(_ pedometerData: CMPedometerData?, _ error: Error?) {
        let db = Firestore.firestore()

        guard let pedometerData = pedometerData else { return }

        let stepsCountDocument = db.collection("activity").document("stepsCount")
           stepsCountDocument.getDocument { [weak self] (document, error) in
               if let document = document, document.exists {
                   if let count = document.data()?["count"] as? Int {
                       let currentSteps = count
                       let stepLengthInMeters = 10.762 // Average step length in meters
                       let totalDistance = (pedometerData.distance?.doubleValue ?? 0) * stepLengthInMeters
                       let totalSteps = Int(totalDistance)
                       let newSteps = currentSteps + totalSteps
                       self?.stepsLabel.text = "\(newSteps)"
                       stepsCountDocument.setData(["count": newSteps])
                   }
               }
           }

        let distanceDocument = db.collection("activity").document("distance")
         distanceDocument.getDocument { [weak self] (document, error) in
             if let document = document, document.exists {
                 if let value = document.data()?["value"] as? Double {
                     let currentDistance = value
                     let stepLengthInMeters = 10.762 // Average step length in meters
                     let totalDistance = (pedometerData.distance?.doubleValue ?? 0) * stepLengthInMeters
                     let newDistance = currentDistance + totalDistance
                     let kilometers = newDistance / 1000.0
                     self?.distanceLabel.text = String(format: "%.2f km", kilometers)
                     distanceDocument.setData(["value": newDistance])
                 }
             }
         }


        let caloriesDocument = db.collection("activity").document("calories")
        caloriesDocument.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                if let value = document.data()?["value"] as? Double {
                    let caloriesPerStep = 0.04 // Assuming 0.04 calories burned per step
                    if let numberOfSteps = pedometerData.numberOfSteps as? NSNumber {
                        let totalCalories = numberOfSteps.doubleValue * caloriesPerStep
                        let newCalories = value + totalCalories
                        self?.caloriesLabel.text = String(format: "%.2f", newCalories)
                        caloriesDocument.setData(["value": newCalories])
                    }
                }
            }
            
        }


        // CLLocationManagerDelegate methods

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                // Location access granted, perform additional operations if needed
            }
        }

        // Other methods...

        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        // Other lifecycle methods...
        }
}

