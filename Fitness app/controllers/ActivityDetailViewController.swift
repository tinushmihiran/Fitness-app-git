////
////  ActivityDetailViewController.swift
////  Fitness app
////
////  Created by Tinush mihiran on 2023-05-16.
////
import UIKit
import CoreMotion
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseAuth

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
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Add "Go Back" button
        let goBackButton = UIButton(type: .system)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.setTitleColor(.white, for: .normal)
        goBackButton.backgroundColor = .black
        goBackButton.layer.cornerRadius = 8
        goBackButton.layer.borderWidth = 2
        goBackButton.layer.borderColor = UIColor.white.cgColor
        goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        view.addSubview(goBackButton)

        NSLayoutConstraint.activate([
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goBackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goBackButton.widthAnchor.constraint(equalToConstant: 150),
            goBackButton.heightAnchor.constraint(equalToConstant: 60)
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
        
        // Fetch and display stored activity data
               if let userId = Auth.auth().currentUser?.uid {
                   let db = Firestore.firestore()
                   let activityRef = db.collection("activities").document(userId)

                   activityRef.getDocument { [weak self] (document, error) in
                       if let document = document, document.exists {
                           let data = document.data()
                           if let steps = data?["steps"] as? Int {
                               self?.stepsLabel.text = "\(steps)"
                           }
                        if let distance = data?["distance"] as? Double {
                            let formattedDistance = String(format: "%.2f", distance)
                            self?.distanceLabel.text = "\(formattedDistance) km"
                        }

                           if let calories = data?["calories"] as? Double {
                               self?.caloriesLabel.text = "\(calories) kcal"
                           }
                       } else {
                           print("Activity document does not exist")
                        // Create a new document for the user
                                       let newActivityData: [String: Any] = [
                                           "steps": 0,
                                           "distance": 0.0,
                                           "calories": 0.0
                                       ]

                                       activityRef.setData(newActivityData) { error in
                                           if let error = error {
                                               print("Error creating activity document: \(error)")
                                           } else {
                                               print("Activity document created")
                                           }
                                       }
                                   }
                               }
                           } else {
                               print("User ID not available")
                       
               }
           }
    
    
    

    @objc private func goBackButtonTapped() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)

        navigationController?.popViewController(animated: false)
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
            distanceLabel.leadingAnchor.constraint(equalTo: activityLabel.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: activityLabel.trailingAnchor),

            caloriesImageView.topAnchor.constraint(equalTo: distanceTitleLabel.bottomAnchor, constant: 28),
            caloriesImageView.leadingAnchor.constraint(equalTo: distanceImageView.leadingAnchor),
            caloriesImageView.widthAnchor.constraint(equalToConstant: 24),
            caloriesImageView.heightAnchor.constraint(equalToConstant: 24),

            caloriesTitleLabel.centerYAnchor.constraint(equalTo: caloriesImageView.centerYAnchor),
            caloriesTitleLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 28),

            caloriesLabel.topAnchor.constraint(equalTo: caloriesTitleLabel.topAnchor),
            caloriesLabel.leadingAnchor.constraint(equalTo: activityLabel.leadingAnchor),
            caloriesLabel.trailingAnchor.constraint(equalTo: activityLabel.trailingAnchor)
        ])
    }

    private func handleActivityUpdate(_ activity: CMMotionActivity?) {
        guard let activity = activity else {
            activityLabel.text = "Unknown"
            return
        }

        var activityString = ""

        if activity.walking {
            activityString = "Walking"
        } else if activity.running {
            activityString = "Running"
        } else if activity.cycling {
            activityString = "Cycling"
        } else if activity.automotive {
            activityString = "Automotive"
        } else if activity.stationary {
            activityString = "Stationary"
        } else if activity.unknown {
            activityString = "Unknown"
        }

        activityLabel.text = activityString
    }

    private func handlePedometerUpdate(_ pedometerData: CMPedometerData?, _ error: Error?) {
            if let error = error {
                print("Error retrieving pedometer data: \(error)")
                stepsLabel.text = "N/A"
                distanceLabel.text = "N/A"
                caloriesLabel.text = "N/A"
                return
            }

            if let steps = pedometerData?.numberOfSteps {
                let stepsValue = steps.intValue
                stepsLabel.text = "\(stepsValue)"
                
                if let distance = pedometerData?.distance {
                    let averageStepLength: Double = 0.75 // in meters
                    let totalDistanceInKm = distance.doubleValue / 1000 // converting distance to kilometers
                    let calculatedSteps = Int(totalDistanceInKm / averageStepLength)
                    
                    if calculatedSteps >= stepsValue {
                        stepsLabel.text = "\(calculatedSteps)"
                    }
                }
            }

            if let distance = pedometerData?.distance {
                // Convert distance to kilometers
                let distanceInKilometers = distance.doubleValue / 1000
                let formattedDistance = String(format: "%.2f", distanceInKilometers)
                distanceLabel.text = "\(formattedDistance) km"
            }

            if let calories = pedometerData?.floorsAscended {
                // Convert floors ascended to calories burned (assuming 1 floor = 10 calories)
                let caloriesBurned = calories.doubleValue * 10
                caloriesLabel.text = "\(caloriesBurned) kcal"
            }

        // Fetch and display stored activity data
        if let userId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            let activityRef = db.collection("activities").document(userId)

            activityRef.getDocument { [weak self] (document, error) in
                if let document = document, document.exists {
                    let data = document.data()

                    // Retrieve previous values from Firestore
                    var totalSteps = 0
                    if let steps = data?["steps"] as? Int {
                        totalSteps += steps
                    }

                    var totalDistance = 0.0
                    if let distance = data?["distance"] as? Double {
                        totalDistance += distance
                    }

                    var totalCalories = 0.0
                    if let calories = data?["calories"] as? Double {
                        totalCalories += calories
                    }

                    // Add new values to the totals
                    if let steps = pedometerData?.numberOfSteps {
                        totalSteps += steps.intValue
                    }

                    if let distance = pedometerData?.distance {
                        let distanceInKm = distance.doubleValue / 1000
                        totalDistance += distanceInKm
                    }

                    if let calories = pedometerData?.floorsAscended {
                        let caloriesBurned = calories.doubleValue * 10
                        totalCalories += caloriesBurned
                    }

                    // Update the labels with the new totals
                    self?.stepsLabel.text = "\(totalSteps)"
                    let formattedDistance = String(format: "%.2f", totalDistance)
                    self?.distanceLabel.text = "\(formattedDistance) km"
                    self?.caloriesLabel.text = "\(totalCalories) kcal"

                    // Save the updated totals to Firestore
                    let activityData: [String: Any] = [
                        "steps": totalSteps,
                        "distance": totalDistance,
                        "calories": totalCalories
                    ]

                    activityRef.setData(activityData) { error in
                        if let error = error {
                            print("Error saving activity data to Firestore: \(error)")
                        } else {
                            print("Activity data saved to Firestore")
                        }
                    }
                } else {
                    print("Activity document does not exist")
                }
            }
        }
        }
    
    

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
}

