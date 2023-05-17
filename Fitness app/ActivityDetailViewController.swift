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
import FirebaseFirestore
import HealthKit

class ActivityDetailViewController: UIViewController, CLLocationManagerDelegate {

    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    let activityQueue = OperationQueue()
    let locationManager = CLLocationManager()

    lazy var activityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Activity:"
        return label
    }()

    lazy var activityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    lazy var stepsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Steps:"
        return label
    }()

    lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    lazy var distanceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Distance:"
        return label
    }()

    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    lazy var caloriesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Calories Burned:"
        return label
    }()

    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Configure Firebase
           FirebaseApp.configure()
           
           // Set up Firestore
           let db = Firestore.firestore()
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

    private func setupLabels() {
        view.addSubview(activityTitleLabel)
        view.addSubview(activityLabel)
        view.addSubview(stepsTitleLabel)
        view.addSubview(stepsLabel)
        view.addSubview(distanceTitleLabel)
        view.addSubview(distanceLabel)
        view.addSubview(caloriesTitleLabel)
        view.addSubview(caloriesLabel)

            NSLayoutConstraint.activate([
                activityTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                activityTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

                activityLabel.topAnchor.constraint(equalTo: activityTitleLabel.topAnchor),
                activityLabel.leadingAnchor.constraint(equalTo: activityTitleLabel.trailingAnchor, constant: 8),
                activityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                stepsTitleLabel.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 16),
                stepsTitleLabel.leadingAnchor.constraint(equalTo: activityTitleLabel.leadingAnchor),

                stepsLabel.topAnchor.constraint(equalTo: stepsTitleLabel.topAnchor),
                stepsLabel.leadingAnchor.constraint(equalTo: activityLabel.leadingAnchor),
                stepsLabel.trailingAnchor.constraint(equalTo: activityLabel.trailingAnchor),

                distanceTitleLabel.topAnchor.constraint(equalTo: stepsTitleLabel.bottomAnchor, constant: 8),
                distanceTitleLabel.leadingAnchor.constraint(equalTo: stepsTitleLabel.leadingAnchor),

                distanceLabel.topAnchor.constraint(equalTo: distanceTitleLabel.topAnchor),
                distanceLabel.leadingAnchor.constraint(equalTo: stepsLabel.leadingAnchor),
                distanceLabel.trailingAnchor.constraint(equalTo: stepsLabel.trailingAnchor),

                caloriesTitleLabel.topAnchor.constraint(equalTo: distanceTitleLabel.bottomAnchor, constant: 8),
                caloriesTitleLabel.leadingAnchor.constraint(equalTo: distanceTitleLabel.leadingAnchor),

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
        guard let pedometerData = pedometerData else { return }
        
        if let numberOfSteps = pedometerData.numberOfSteps as? Int {
            stepsLabel.text = "Steps: \(numberOfSteps)"
        }
        
        if let distance = pedometerData.distance as? Double {
            let kilometers = distance / 1000.0
            distanceLabel.text = String(format: "Distance: %.2f km", kilometers)
        }
        
        if let activeEnergyBurned = pedometerData.activeEnergyBurned {
            let calories = activeEnergyBurned.doubleValue(for: HKUnit.kilocalorie())
            caloriesLabel.text = String(format: "Move/Cal: %.2f", calories)
            
            let db = Firestore.firestore()
            let data: [String: Any] = [
                "steps": numberOfSteps,
                "distance": kilometers,
                "calories": calories,
                "timestamp": Date()
            ]
            
            let docRef = db.collection("activityData").document()
            docRef.setData(data) { (error) in
                if let error = error {
                    print("Error writing document to Firestore: \(error.localizedDescription)")
                } else {
                    print("Document successfully written to Firestore.")
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

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        // Other lifecycle methods...
        }
