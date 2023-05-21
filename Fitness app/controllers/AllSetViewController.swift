//
//  AllSetViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-20.
//

    import UIKit

    class AllSetViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            
            // Create "All Set" label
            let allSetLabel = UILabel()
            allSetLabel.text = "All Set"
            allSetLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            allSetLabel.textAlignment = .center
            allSetLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(allSetLabel)
            
            NSLayoutConstraint.activate([
                allSetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                allSetLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            ])
            
            // Create correct mark animation view
            let correctMarkView = UIView()
            correctMarkView.backgroundColor = .clear
            correctMarkView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(correctMarkView)
            
            NSLayoutConstraint.activate([
                correctMarkView.widthAnchor.constraint(equalToConstant: 100),
                correctMarkView.heightAnchor.constraint(equalToConstant: 100),
                correctMarkView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                correctMarkView.topAnchor.constraint(equalTo: allSetLabel.bottomAnchor, constant: 20)
            ])
            
            let correctMarkLayer = CAShapeLayer()
            let correctMarkPath = UIBezierPath()
            correctMarkPath.move(to: CGPoint(x: 20, y: 50))
            correctMarkPath.addLine(to: CGPoint(x: 40, y: 70))
            correctMarkPath.addLine(to: CGPoint(x: 80, y: 30))
            correctMarkLayer.path = correctMarkPath.cgPath
            correctMarkLayer.strokeColor = UIColor.green.cgColor
            correctMarkLayer.fillColor = UIColor.clear.cgColor
            correctMarkLayer.lineWidth = 5.0
            correctMarkLayer.strokeEnd = 0.0
            correctMarkView.layer.addSublayer(correctMarkLayer)

            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.fromValue = 0.0
            strokeEndAnimation.toValue = 1.0
            strokeEndAnimation.duration = 1.0
            correctMarkLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
            correctMarkLayer.strokeEnd = 1.0
            
            // Create "Go to BMI Calculator" label
            let bmiLabel = UILabel()
            bmiLabel.text = "Note : Go to BMI Calculator and calculate the BMI value and get suggested plan for you"
            bmiLabel.font = UIFont.systemFont(ofSize: 15)
            bmiLabel.textColor = .black
            bmiLabel.textAlignment = .center
            bmiLabel.numberOfLines = 0
            bmiLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bmiLabel)
            
            NSLayoutConstraint.activate([
                bmiLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                bmiLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                bmiLabel.topAnchor.constraint(equalTo: correctMarkView.bottomAnchor, constant: 40)
            ])
            
            // Create "Next" button
            let nextButton = UIButton(type: .system)
            nextButton.setTitle("Next", for: .normal)
            nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.backgroundColor = .black
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(nextButton)
            
            NSLayoutConstraint.activate([
                nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                nextButton.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
        
        @objc func nextButtonTapped() {
            let exerciseViewController = ExerciseViewController()
            navigationController?.pushViewController(exerciseViewController, animated: true)
        }
    }
