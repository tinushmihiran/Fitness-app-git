//
//  ProfileDetailGetViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-17.
//

//import UIKit
//import FirebaseFirestore
//
//class ProfileDetailGetViewController: UIViewController, UIPickerViewDelegate {
//
//    // MARK: - Properties
//
//    private let firestore = Firestore.firestore()
//
//    private var ageTextField: UITextField!
//    private var genderDropdown: UIPickerView!
//    private var heightSlider: UISlider!
//    private var activityLevelSegmentedControl: UISegmentedControl!
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//    }
//
//    // MARK: - UI Setup
//
//    private func setupUI() {
//        view.backgroundColor = .white
//
//        // Age Text Field
//        ageTextField = UITextField()
//        ageTextField.placeholder = "Age"
//        ageTextField.borderStyle = .roundedRect
//        ageTextField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(ageTextField)
//
//        // Gender Dropdown
//        genderDropdown = UIPickerView()
//        genderDropdown.delegate = self
//        genderDropdown.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(genderDropdown)
//
//        // Height Slider
//        heightSlider = UISlider()
//        heightSlider.minimumValue = 100
//        heightSlider.maximumValue = 200
//        heightSlider.value = 150
//        heightSlider.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(heightSlider)
//
//        // Activity Level Segmented Control
//        activityLevelSegmentedControl = UISegmentedControl(items: ["Low", "Medium", "High"])
//        activityLevelSegmentedControl.selectedSegmentIndex = 0
//        activityLevelSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(activityLevelSegmentedControl)
//
//        // Next Button
//        let nextButton = UIButton(type: .system)
//        nextButton.setTitle("Next", for: .normal)
//        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nextButton)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            ageTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//            ageTextField.widthAnchor.constraint(equalToConstant: 200),
//
//            genderDropdown.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            genderDropdown.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
//
//            heightSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            heightSlider.topAnchor.constraint(equalTo: genderDropdown.bottomAnchor, constant: 20),
//
//            activityLevelSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityLevelSegmentedControl.topAnchor.constraint(equalTo: heightSlider.bottomAnchor, constant: 20),
//
//            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nextButton.topAnchor.constraint(equalTo: activityLevelSegmentedControl.bottomAnchor, constant: 40)
//        ])
//    }
//
//    // MARK: - Actions
//
//    @objc private func nextButtonTapped() {
//        guard let ageText = ageTextField.text,
//              let height = heightSlider?.value else {
//            return
//        }
//
//        let gender = genderDropdown.selectedRow(inComponent: 0) == 0 ? "Male" : "Female"
//        let activityLevel = activityLevelSegmentedControl.selectedSegmentIndex
//
//        // Save the details to Firestore
//        let docData: [String: Any] = [
//            "age": ageText,
//            "gender": gender,
//            "height": height,
//            "activityLevel": activityLevel
//        ]
//
//        firestore.collection("profiles").addDocument(data: docData) { error in
//            if let error = error {
//                print("Error saving profile: \(error.localizedDescription)")
//            } else {
//                print("Profile saved successfully")
//                // Navigate to the next screen (ExerciseViewController)
//                let exerciseVC = ExerciseViewController()
//                self.navigationController?.pushViewController(exerciseVC, animated: true)
//            }
//        }
//    }
//}
//
//extension ProfileDetailGetViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return row == 0 ? "Male" : "Female"
//    }
//}


//import UIKit
//import FirebaseFirestore
//
//class ProfileDetailGetViewController: UIViewController, UIPickerViewDelegate {
//
//    // MARK: - Properties
//
//    private let firestore = Firestore.firestore()
//
//    private var nameTextField: UITextField!
//    private var ageTextField: UITextField!
//    private var genderDropdown: UIPickerView!
//    private var heightSlider: UISlider!
//    private var activityLevelSegmentedControl: UISegmentedControl!
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//    }
//
//    // MARK: - UI Setup
//
//    private func setupUI() {
//        view.backgroundColor = .white
//
//        // Name Text Field
//        nameTextField = UITextField()
//        nameTextField.placeholder = "Name"
//        nameTextField.borderStyle = .roundedRect
//        nameTextField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nameTextField)
//
//        // Age Text Field
//        ageTextField = UITextField()
//        ageTextField.placeholder = "Age"
//        ageTextField.borderStyle = .roundedRect
//        ageTextField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(ageTextField)
//
//        // Gender Dropdown
//        genderDropdown = UIPickerView()
//        genderDropdown.delegate = self
//        genderDropdown.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(genderDropdown)
//
//        // Height Slider
//        heightSlider = UISlider()
//        heightSlider.minimumValue = 100
//        heightSlider.maximumValue = 200
//        heightSlider.value = 150
//        heightSlider.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(heightSlider)
//
//        // Activity Level Segmented Control
//        activityLevelSegmentedControl = UISegmentedControl(items: ["Low", "Medium", "High"])
//        activityLevelSegmentedControl.selectedSegmentIndex = 0
//        activityLevelSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(activityLevelSegmentedControl)
//
//        // Next Button
//        let nextButton = UIButton(type: .system)
//        nextButton.setTitle("Next", for: .normal)
//        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nextButton)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//            nameTextField.widthAnchor.constraint(equalToConstant: 200),
//
//            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
//            ageTextField.widthAnchor.constraint(equalToConstant: 200),
//
//            genderDropdown.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            genderDropdown.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
//
//            heightSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            heightSlider.topAnchor.constraint(equalTo: genderDropdown.bottomAnchor, constant: 20),
//
//            activityLevelSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityLevelSegmentedControl.topAnchor.constraint(equalTo: heightSlider.bottomAnchor, constant: 20),
//
//            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nextButton.topAnchor.constraint(equalTo: activityLevelSegmentedControl.bottomAnchor, constant: 40)
//        ])
//    }
//
//    // MARK: - Actions
//
//    @objc private func nextButtonTapped() {
//        guard let name = nameTextField.text,
//              let ageText = ageTextField.text,
//              let height = heightSlider?.value else {
//            return
//        }
//
//        let gender = genderDropdown.selectedRow(inComponent: 0) == 0 ? "Male" : "Female"
//        let activityLevel = activityLevelSegmentedControl.selectedSegmentIndex
//
//        // Validate required fields
//        if name.isEmpty || ageText.isEmpty {
//            showAlert(message: "Please fill in all fields.")
//            return
//        }
//
//        // Save the details to Firestore
//        let docData: [String: Any] = [
//            "name": name,
//            "age": ageText,
//            "gender": gender,
//            "height": height,
//            "activityLevel": activityLevel
//        ]
//
//        firestore.collection("profiles").addDocument(data: docData) { error in
//            if let error = error {
//                print("Error saving profile: \(error.localizedDescription)")
//            } else {
//                print("Profile saved successfully")
//                // Navigate to the next screen (ExerciseViewController)
//                let exerciseVC = ExerciseViewController()
//                self.navigationController?.pushViewController(exerciseVC, animated: true)
//            }
//        }
//    }
//
//    // MARK: - Helper
//
//    private func showAlert(message: String) {
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
//    }
//}
//
//extension ProfileDetailGetViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return row == 0 ? "Male" : "Female"
//    }
//}
//workeeddd

//import UIKit
//import FirebaseFirestore
//
//class ProfileDetailGetViewController: UIViewController, UIPickerViewDelegate {
//
//    // MARK: - Properties
//
//    private let firestore = Firestore.firestore()
//
//    private var nameTextField: UITextField!
//    private var ageTextField: UITextField!
//    private var genderDropdown: UIPickerView!
//    private var heightSlider: UISlider!
//    private var heightLabel: UILabel!
//    private var activityLevelSegmentedControl: UISegmentedControl!
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//    }
//
//    // MARK: - UI Setup
//
//    private func setupUI() {
//        view.backgroundColor = .white
//
//        // Title Label
//        let titleLabel = UILabel()
//        titleLabel.text = "Add Profile Details"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        titleLabel.textAlignment = .center
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(titleLabel)
//
//        // Name Text Field
//        nameTextField = UITextField()
//        nameTextField.placeholder = "Name"
//        nameTextField.borderStyle = .roundedRect
//        nameTextField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nameTextField)
//
//        // Age Text Field
//        ageTextField = UITextField()
//        ageTextField.placeholder = "Age"
//        ageTextField.borderStyle = .roundedRect
//        ageTextField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(ageTextField)
//
//        // Gender Dropdown
//        genderDropdown = UIPickerView()
//        genderDropdown.delegate = self
//        genderDropdown.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(genderDropdown)
//
//        // Title Labe2
//        let titleLabel2 = UILabel()
//        titleLabel2.text = "Select Height"
//        titleLabel2.font = UIFont.boldSystemFont(ofSize: 18)
//        titleLabel2.textAlignment = .center
//        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(titleLabel2)
//
//        // Height Slider
//        heightSlider = UISlider()
//        heightSlider.minimumValue = 0
//        heightSlider.maximumValue = 200
//        heightSlider.value = 150
//        heightSlider.isContinuous = true
//        heightSlider.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(heightSlider)
//
//        // Height Label
//        heightLabel = UILabel()
//        heightLabel.textAlignment = .center
//        heightLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(heightLabel)
//
//        // Title Label for Activity Level
//        let activityLevelTitleLabel = UILabel()
//        activityLevelTitleLabel.text = "Activity Level"
//        activityLevelTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        activityLevelTitleLabel.textAlignment = .center
//        activityLevelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(activityLevelTitleLabel)
//
//        // Activity Level Segmented Control
//        activityLevelSegmentedControl = UISegmentedControl(items: ["Low", "Medium", "High"])
//        activityLevelSegmentedControl.selectedSegmentIndex = 0
//        activityLevelSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(activityLevelSegmentedControl)
//
//        // Next Button
//        let nextButton = UIButton(type: .system)
//        nextButton.setTitle("Next", for: .normal)
//        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nextButton)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            titleLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel2.bottomAnchor.constraint(equalTo: heightSlider.topAnchor, constant: -20),
//
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//
//            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            nameTextField.widthAnchor.constraint(equalToConstant: 200),
//
//            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
//            ageTextField.widthAnchor.constraint(equalToConstant: 200),
//
//            genderDropdown.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            genderDropdown.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
//
//            heightSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            heightSlider.topAnchor.constraint(equalTo: genderDropdown.bottomAnchor, constant: 40),
//            heightSlider.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
//
//            heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            heightLabel.topAnchor.constraint(equalTo: heightSlider.bottomAnchor, constant: 10),
//
//            activityLevelTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityLevelTitleLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20),
//
//            activityLevelSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityLevelSegmentedControl.topAnchor.constraint(equalTo: activityLevelTitleLabel.bottomAnchor, constant: 10),
//
//            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nextButton.topAnchor.constraint(equalTo: activityLevelSegmentedControl.bottomAnchor, constant: 40)
//        ])
//
//        // Update the height label when the slider value changes
//        heightSlider.addTarget(self, action: #selector(heightSliderValueChanged), for: .valueChanged)
//    }
//
//    // MARK: - Actions
//
//    @objc private func nextButtonTapped() {
//        guard let name = nameTextField.text,
//              let ageText = ageTextField.text,
//              let height = heightSlider?.value else {
//            return
//        }
//
//        let gender = genderDropdown.selectedRow(inComponent: 0) == 0 ? "Male" : "Female"
//        let activityLevel = activityLevelSegmentedControl.selectedSegmentIndex
//
//        // Validate required fields
//        if name.isEmpty || ageText.isEmpty {
//            showAlert(message: "Please fill in all fields.")
//            return
//        }
//
//        // Save the details to Firestore
//        let docData: [String: Any] = [
//            "name": name,
//            "age": ageText,
//            "gender": gender,
//            "height": height,
//            "activityLevel": activityLevel
//        ]
//
//        firestore.collection("profiles").addDocument(data: docData) { error in
//            if let error = error {
//                print("Error saving profile: \(error.localizedDescription)")
//            } else {
//                print("Profile saved successfully")
//                // Navigate to the next screen (ExerciseViewController)
//                let exerciseVC = ExerciseViewController()
//                self.navigationController?.pushViewController(exerciseVC, animated: true)
//            }
//        }
//    }
//
//    @objc private func heightSliderValueChanged() {
//        let height = Int(heightSlider.value)
//        heightLabel.text = "\(height) cm"
//    }
//
//    // MARK: - Helper
//
//    private func showAlert(message: String) {
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
//    }
//}
//
//extension ProfileDetailGetViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return row == 0 ? "Male" : "Female"
//    }
//}



import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileDetailGetViewController: UIViewController, UIPickerViewDelegate {

    // MARK: - Properties
    
    private let firestore = Firestore.firestore()
    
    private var nameTextField: UITextField!
    private var ageTextField: UITextField!
    private var genderDropdown: UIPickerView!
    private var heightSlider: UISlider!
    private var heightLabel: UILabel!
    private var activityLevelSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Add Profile Details"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Name Text Field
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        // Age Text Field
        ageTextField = UITextField()
        ageTextField.placeholder = "Age"
        ageTextField.borderStyle = .roundedRect
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ageTextField)
        
        // Gender Dropdown
        genderDropdown = UIPickerView()
        genderDropdown.delegate = self
        genderDropdown.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderDropdown)
        
        // Title Label2
        let titleLabel2 = UILabel()
        titleLabel2.text = "Select Height"
        titleLabel2.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel2.textAlignment = .center
        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel2)
        
        // Height Slider
        heightSlider = UISlider()
        heightSlider.minimumValue = 0
        heightSlider.maximumValue = 200
        heightSlider.value = 150
        heightSlider.isContinuous = true
        heightSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heightSlider)
        
        // Height Label
        heightLabel = UILabel()
        heightLabel.textAlignment = .center
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heightLabel)
        
        // Title Label for Activity Level
        let activityLevelTitleLabel = UILabel()
        activityLevelTitleLabel.text = "Activity Level"
        activityLevelTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        activityLevelTitleLabel.textAlignment = .center
        activityLevelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityLevelTitleLabel)
        
        // Activity Level Segmented Control
        activityLevelSegmentedControl = UISegmentedControl(items: ["Low", "Medium", "High"])
        activityLevelSegmentedControl.selectedSegmentIndex = 0
        activityLevelSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityLevelSegmentedControl)
        
        // Next Button
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel2.bottomAnchor.constraint(equalTo: heightSlider.topAnchor, constant: -20),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),

            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageTextField.widthAnchor.constraint(equalToConstant: 200),

            genderDropdown.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderDropdown.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),

            heightSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightSlider.topAnchor.constraint(equalTo: genderDropdown.bottomAnchor, constant: 40),
            heightSlider.widthAnchor.constraint(equalToConstant: view.frame.width - 40),

            heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightLabel.topAnchor.constraint(equalTo: heightSlider.bottomAnchor, constant: 10),

            activityLevelTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityLevelTitleLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20),

            activityLevelSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityLevelSegmentedControl.topAnchor.constraint(equalTo: activityLevelTitleLabel.bottomAnchor, constant: 10),

            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: activityLevelSegmentedControl.bottomAnchor, constant: 40)
        ])
        
        // Update the height label when the slider value changes
        heightSlider.addTarget(self, action: #selector(heightSliderValueChanged), for: .valueChanged)
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonTapped() {
        guard let name = nameTextField.text,
              let ageText = ageTextField.text,
              let height = heightSlider?.value,
              let userEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        let gender = genderDropdown.selectedRow(inComponent: 0) == 0 ? "Male" : "Female"
        let activityLevel = activityLevelSegmentedControl.selectedSegmentIndex
        
        // Validate required fields
        if name.isEmpty || ageText.isEmpty {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        // Save the details to Firestore
        let docData: [String: Any] = [
            "name": name,
            "age": ageText,
            "gender": gender,
            "height": height,
            "activityLevel": activityLevel,
            "email": userEmail
        ]
        
        firestore.collection("profiles").document(userEmail).setData(docData) { error in
            if let error = error {
                print("Error saving profile: \(error.localizedDescription)")
            } else {
                print("Profile saved successfully")
                // Navigate to the next screen (ExerciseViewController)
                let exerciseVC = ExerciseViewController()
                self.navigationController?.pushViewController(exerciseVC, animated: true)
            }
        }
    }
    
    @objc private func heightSliderValueChanged() {
        let height = Int(heightSlider.value)
        heightLabel.text = "\(height) cm"
    }
    
    // MARK: - Helper
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ProfileDetailGetViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? "Male" : "Female"
    }
}

