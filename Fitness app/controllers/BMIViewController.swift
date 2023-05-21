//
//  BMIViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-13.
//


import UIKit
import Firebase

class BMIViewController: UIViewController {

    var weightTextField: UITextField!
    var heightTextField: UITextField!
    var calculateButton: UIButton!
    var bmiLabel: UILabel!
    var cardViews: [UIView] = []

    let firestore = Firestore.firestore()

    var suggestedPlans: [FitnessPlan] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)

        // Create back button
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))

        // Add back button to navigation item
        navigationItem.leftBarButtonItem = backButton

        setupWeightTextField()
        setupHeightTextField()
        setupCalculateButton()
        setupBmiLabel()
        
        // Add tap gesture recognizer to dismiss the keyboard
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }

    func setupWeightTextField() {
        weightTextField = UITextField()
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.placeholder = "Enter your weight (kg)"
        weightTextField.keyboardType = .decimalPad
        weightTextField.borderStyle = .roundedRect
        weightTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        weightTextField.layer.cornerRadius = 10

        view.addSubview(weightTextField)

        NSLayoutConstraint.activate([
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weightTextField.widthAnchor.constraint(equalToConstant: 200),
            weightTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupHeightTextField() {
        heightTextField = UITextField()
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.placeholder = "Enter your height (m)"
        heightTextField.keyboardType = .decimalPad
        heightTextField.borderStyle = .roundedRect
        heightTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        heightTextField.layer.cornerRadius = 10

        view.addSubview(heightTextField)

        NSLayoutConstraint.activate([
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightTextField.widthAnchor.constraint(equalToConstant: 200),
            heightTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupCalculateButton() {
        calculateButton = UIButton()
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.setTitle("Calculate BMI", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.addTarget(self, action: #selector(calculateBMI), for: .touchUpInside)
        calculateButton.backgroundColor = .systemBlue
        calculateButton.layer.cornerRadius = 10

        view.addSubview(calculateButton)

        NSLayoutConstraint.activate([
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            calculateButton.widthAnchor.constraint(equalToConstant: 150),
            calculateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupBmiLabel() {
        bmiLabel = UILabel()
        bmiLabel.translatesAutoresizingMaskIntoConstraints = false
        bmiLabel.text = "Your BMI will appear here"
        bmiLabel.textAlignment = .center
        bmiLabel.font = UIFont.systemFont(ofSize: 20)
        bmiLabel.numberOfLines = 0

        view.addSubview(bmiLabel)

        NSLayoutConstraint.activate([
            bmiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bmiLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 20),
            bmiLabel.widthAnchor.constraint(equalToConstant: 250),
            bmiLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }

    @objc func calculateBMI() {
        guard let weightText = weightTextField.text,
              let heightText = heightTextField.text,
              let weight = Double(weightText),
              let height = Double(heightText),
              height > 0 else {
            bmiLabel.text = "Invalid input"
            return
        }

        let bmi = weight / (height * height)
        bmiLabel.text = String(format: "Your BMI is %.2f", bmi)

        clearCardViews()
        fetchFitnessPlans(bmi: bmi)
    }

    func clearCardViews() {
        for cardView in cardViews {
            cardView.removeFromSuperview()
        }
        cardViews.removeAll()
    }

    func fetchFitnessPlans(bmi: Double) {
        var collectionName: String

        if bmi < 18.5 {
            collectionName = "beginner_plans"
        } else if bmi >= 18.5 && bmi < 25 {
            collectionName = "intermediate_plans"
        } else {
            collectionName = "advanced_plans"
        }

        let plansCollection = firestore.collection(collectionName)

        plansCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching fitness plans: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No fitness plans found")
                return
            }

            self.suggestedPlans = []

            for document in documents {
                guard let planData = document.data() as? [String: Any],
                      let name = planData["name"] as? String,
                      let level = planData["level"] as? String,
                      let details = planData["details"] as? String,
                      let days = planData["days"] as? String else {
                    continue
                }

                let plan = FitnessPlan(name: name, level: level, details: details, days: days)
                self.suggestedPlans.append(plan)
            }

            if self.suggestedPlans.isEmpty {
                self.suggestedPlans.append(FitnessPlan(name: "No fitness plans available for your BMI", level: "", details: "", days: ""))
            }

            self.displayFitnessPlans(self.suggestedPlans)
        }
    }

    func displayFitnessPlans(_ plans: [FitnessPlan]) {
        var previousCardView: UIView?

        for (index, plan) in plans.enumerated() {
            let cardView = UIView()
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 10
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.5
            cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cardView.layer.shadowRadius = 2

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardViewTapped(_:)))
            cardView.addGestureRecognizer(tapGesture)
            // Apply scaling animation
            cardView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)


            // Apply spring animation to restore original size
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
                cardView.transform = .identity
            }, completion: nil)



            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = plan.name
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0

            let levelLabel = UILabel()
            levelLabel.translatesAutoresizingMaskIntoConstraints = false
            levelLabel.text = "Level: \(plan.level)"
            levelLabel.textAlignment = .center
            levelLabel.font = UIFont.systemFont(ofSize: 14)
            levelLabel.textColor = .darkGray

            let detailsLabel = UILabel()
            detailsLabel.translatesAutoresizingMaskIntoConstraints = false
            detailsLabel.text = plan.details
            detailsLabel.textAlignment = .center
            detailsLabel.font = UIFont.systemFont(ofSize: 14)
            detailsLabel.textColor = .darkGray
            detailsLabel.numberOfLines = 0

            let daysLabel = UILabel()
            daysLabel.translatesAutoresizingMaskIntoConstraints = false
            daysLabel.text = "Days: \(plan.days)"
            daysLabel.textAlignment = .center
            daysLabel.font = UIFont.systemFont(ofSize: 14)
            daysLabel.textColor = .darkGray

            cardView.addSubview(titleLabel)
            cardView.addSubview(levelLabel)
            cardView.addSubview(detailsLabel)
            cardView.addSubview(daysLabel)

            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),

                levelLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                levelLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
                levelLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),

                detailsLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 5),
                detailsLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
                detailsLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),

                daysLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
                daysLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
                daysLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
                daysLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
            ])

            view.addSubview(cardView)

            NSLayoutConstraint.activate([
                cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
            ])

            if let previousCardView = previousCardView {
                cardView.topAnchor.constraint(equalTo: previousCardView.bottomAnchor, constant: 20).isActive = true
            } else {
                cardView.topAnchor.constraint(equalTo: bmiLabel.bottomAnchor, constant: 20).isActive = true
            }

            cardViews.append(cardView)
            previousCardView = cardView
        }
    }

    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @objc func cardViewTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedCardView = sender.view, let index = cardViews.firstIndex(of: tappedCardView) else {
            return
        }

        let plan = suggestedPlans[index]
        let alertController = UIAlertController(title: plan.name, message: "Level: \(plan.level)\nDetails: \(plan.details)\nDays: \(plan.days)", preferredStyle: .alert)

        let attributedTitle = NSMutableAttributedString(string: plan.name)
        let titleFontSize: CGFloat = 20

        attributedTitle.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: titleFontSize), range: NSRange(location: 0, length: plan.name.count))
        alertController.setValue(attributedTitle, forKey: "attributedTitle")

        let message = alertController.message ?? ""
        let attributedMessage = NSMutableAttributedString(string: message)
        let messageFontSize: CGFloat = 18

        // Bold the level, details, and days titles
        let boldFont = UIFont.boldSystemFont(ofSize: messageFontSize)
        let levelRange = (message as NSString).range(of: "Level:")
        let detailsRange = (message as NSString).range(of: "Details:")
        let daysRange = (message as NSString).range(of: "Days:")

        attributedMessage.addAttribute(.font, value: boldFont, range: levelRange)
        attributedMessage.addAttribute(.font, value: boldFont, range: detailsRange)
        attributedMessage.addAttribute(.font, value: boldFont, range: daysRange)

        alertController.setValue(attributedMessage, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }



    @objc func goBack() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.popViewController(animated: true)
    }

}

struct FitnessPlan {
    let name: String
    let level: String
    let details: String
    let days: String
}
