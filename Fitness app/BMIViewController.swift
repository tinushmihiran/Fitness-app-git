//import UIKit
//import FirebaseFirestore
//
//class BMIViewController: UIViewController, UITextFieldDelegate {
//
//    private let label: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
//
//    private let field: UITextField = {
//        let field = UITextField()
//        field.placeholder = "Enter Schedule Name"
//        field.layer.borderWidth = 1
//        field.layer.borderColor = UIColor.black.cgColor
//        return field
//    }()
//
//    let database = Firestore.firestore()
//
//    // Declare saveButton as an instance property
//    private let saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Save", for: .normal)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        // Add label, field, and save button as subviews
//        view.addSubview(label)
//        view.addSubview(field)
//        view.addSubview(saveButton)
//
//        // Set the text field's delegate to self
//        field.delegate = self
//
//        // Set the save button's target and action
//        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//
//        let docRef = database.document("/Schedules/ScheduleData")
//        docRef.addSnapshotListener { [weak self] snapshot, error in
//            guard let data = snapshot?.data(), error == nil else {
//                return
//            }
//
//            guard let text = data["text"] as? String else {
//                return
//            }
//
//            DispatchQueue.main.async {
//                self?.label.text = text
//            }
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        // Calculate the center Y position based on the safe area insets
//        let centerY = view.safeAreaInsets.top + (view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) / 2
//
//        // Set the frames of the label, text field, and save button
//        label.frame = CGRect(x: 10, y: centerY - 100, width: view.bounds.width - 20, height: 100)
//        field.frame = CGRect(x: 10, y: centerY - 25, width: view.bounds.width - 140, height: 50)
//        saveButton.frame = CGRect(x: field.frame.maxX + 10, y: field.frame.minY, width: view.bounds.width - field.frame.maxX - 20, height: 50)
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let text = textField.text, !text.isEmpty {
//            saveData(text: text)
//        }
//        return true
//    }
//
//    func saveData(text: String) {
//        let docRef = Firestore.firestore().document("/Schedules/ScheduleData")
//        docRef.setData(["text": text])
//    }
//
//    @objc func saveButtonTapped() {
//        if let text = field.text, !text.isEmpty {
//            saveData(text: text)
//            field.text = ""
//        }
//    }
//}

import UIKit

class BMIViewController: UIViewController {

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


