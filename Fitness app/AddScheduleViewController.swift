//
//  AddScheduleViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-20.
//


    import UIKit
    import Firebase

    class AddScheduleViewController: UIViewController {
        let db = Firestore.firestore()

        lazy var nameTextField: UITextField = {
            let textField = UITextField()
            // Customize text field properties
            textField.placeholder = "Exercise Name"
            // Add any necessary constraints
            return textField
        }()
        
        lazy var descriptionTextField: UITextField = {
            let textField = UITextField()
            // Customize text field properties
            textField.placeholder = "Exercise Description"
            // Add any necessary constraints
            return textField
        }()
        
        lazy var muscleTextField: UITextField = {
            let textField = UITextField()
            // Customize text field properties
            textField.placeholder = "Targeted Muscle"
            // Add any necessary constraints
            return textField
        }()
        
        lazy var daysTextField: UITextField = {
            let textField = UITextField()
            // Customize text field properties
            textField.placeholder = "Days to exercise"
            // Add any necessary constraints
            return textField
        }()
        
        lazy var addButton: UIButton = {
            let button = UIButton(type: .system)
            // Customize button properties
            button.setTitle("Add Exercise", for: .normal)
            button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            button.backgroundColor = .black // Set the button's background color
            button.setTitleColor(.white, for: .normal) // Set the button's text color
            button.layer.cornerRadius = 5 // Set the button's corner radius
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17) // Set the button's font
            button.translatesAutoresizingMaskIntoConstraints = false // Make sure this is set to false
            return button
        }()
        

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            // Create title labels
               let nameLabel = UILabel()
               nameLabel.text = "Exercise Name"
        
               
               let descriptionLabel = UILabel()
               descriptionLabel.text = "Exercise Description"
               
               let muscleLabel = UILabel()
               muscleLabel.text = "Targeted Muscle"
               
               let daysLabel = UILabel()
               daysLabel.text = "Days To Exercise"
            
            
            // Create a stack view
                  let stackView = UIStackView()
                  stackView.axis = .vertical
                  stackView.spacing = 16
                  stackView.translatesAutoresizingMaskIntoConstraints = false
                  
            // Add labels and text fields to the stack view
               stackView.addArrangedSubview(nameLabel)
               stackView.addArrangedSubview(nameTextField)
               stackView.addArrangedSubview(descriptionLabel)
               stackView.addArrangedSubview(descriptionTextField)
               stackView.addArrangedSubview(muscleLabel)
               stackView.addArrangedSubview(muscleTextField)
               stackView.addArrangedSubview(daysLabel)
               stackView.addArrangedSubview(daysTextField)
               stackView.addArrangedSubview(addButton)
               
                  // Add the stack view to the view hierarchy
                  view.addSubview(stackView)
                  
                  // Configure stack view constraints
                  NSLayoutConstraint.activate([
                      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                  ])
            
            // Add additional constraints for individual components
              let componentConstraints = [
                  nameLabel.heightAnchor.constraint(equalToConstant: 20),
                  nameTextField.heightAnchor.constraint(equalToConstant: 40),
                  descriptionLabel.heightAnchor.constraint(equalToConstant: 20),
                  descriptionTextField.heightAnchor.constraint(equalToConstant: 80),
                  muscleLabel.heightAnchor.constraint(equalToConstant: 20),
                  muscleTextField.heightAnchor.constraint(equalToConstant: 40),
                  daysLabel.heightAnchor.constraint(equalToConstant: 20),
                  daysTextField.heightAnchor.constraint(equalToConstant: 40),
                  addButton.heightAnchor.constraint(equalToConstant: 40)
              ]
              NSLayoutConstraint.activate(componentConstraints)
            
            // Add constraints for the addButton
            addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            addButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            
           

            // Add border to the text fields
               let textFields = [nameTextField, descriptionTextField, muscleTextField, daysTextField]
               for textField in textFields {
                   textField.layer.borderWidth = 1
                   textField.layer.borderColor = UIColor.lightGray.cgColor
                   textField.layer.cornerRadius = 5
                   textField.clipsToBounds = true
               }
            
        }
        func createTitleLabel(withText text: String) -> UILabel {
            let titleLabel = UILabel()
            
            // Apply bold and black attributes to the title label text
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 17),
                .foregroundColor: UIColor.black
            ]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            titleLabel.attributedText = attributedText
            
            return titleLabel
        }
        
        @objc func addButtonTapped() {
            guard let name = nameTextField.text,
                  let description = descriptionTextField.text,
                  let muscle = muscleTextField.text,
                  let days = daysTextField.text,
                  !name.isEmpty, !description.isEmpty, !muscle.isEmpty, !days.isEmpty,
                  let currentUserID = Auth.auth().currentUser?.uid else {
                // Display an alert to the user indicating the validation error
                let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let data: [String: Any] = [
                "name": name,
                "description": description,
                "muscle": muscle,
                "days": days,
                "userID": currentUserID // Associate the current user's ID with the document
            ]
            
            db.collection("AddSchedule").addDocument(data: data) { error in
                if let error = error {
                    print("Error adding Schedule: \(error)")
                    
                    // Display an alert to the user indicating the error
                    let alert = UIAlertController(title: "Error", message: "Failed to add Schedule. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("Schedule added successfully!")
                    
                    // Display an alert to the user indicating the success
                    let alert = UIAlertController(title: "Success", message: "Schedule added successfully!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        



    }

