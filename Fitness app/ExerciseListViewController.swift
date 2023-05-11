//
//  ExerciseListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-10.
//
//import UIKit
//
//class ExerciseListViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let headers = [
//            "X-RapidAPI-Key": "326cdc8b41mshd1aa4cddec06375p14559djsne928f73c9596",
//            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
//        ]
//
//        let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let _: Void = session.dataTask(with: request) { (data, response, error) in
//         if error != nil  {
//                    print(error?.localizedDescription)
//                } else  {
//                    print(response)
//                }
//                    if let data = data {
//                        if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]{
//                        print(json)
//                    }
//                }
//            }.resume()
//    }
//
//
//}

import UIKit

class ExerciseListViewController: UIViewController {

    var weightTextField: UITextField!
    var heightTextField: UITextField!
    var calculateButton: UIButton!
    var bmiLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        // Create back button
           let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
           
           // Add back button to navigation item
           navigationItem.leftBarButtonItem = backButton
           
          
        // Set up the UI elements
        setupWeightTextField()
        setupHeightTextField()
        setupCalculateButton()
        setupBmiLabel()

    }

    func setupWeightTextField() {
        weightTextField = UITextField()
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.placeholder = "Enter your weight (kg)"
        weightTextField.keyboardType = .decimalPad
        weightTextField.borderStyle = .roundedRect
        weightTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2) // set background color
        weightTextField.layer.cornerRadius = 10 // set corner radius
        
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
        heightTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2) // set background color
        heightTextField.layer.cornerRadius = 10 // set corner radius
        
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
        calculateButton.backgroundColor = .systemBlue // set background color
        calculateButton.layer.cornerRadius = 10 // set corner radius
        
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
    }
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

