//
//  ProfileViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-17.
//

//import UIKit
//import FirebaseFirestore
//import FirebaseAuth
//
//class ProfileViewController: UIViewController, UIPickerViewDelegate {
//
//    // MARK: - Properties
//
//    private let firestore = Firestore.firestore()
//
//    private var nameLabel: UILabel!
//    private var ageLabel: UILabel!
//    private var genderLabel: UILabel!
//    private var heightLabel: UILabel!
//    private var activityLevelLabel: UILabel!
//    private var logoutButton: UIButton!
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//        fetchProfileDetails()
//        addLogoutButton()
//    }
//
//    // MARK: - UI Setup
//
//    private func setupUI() {
//        view.backgroundColor = .white
//
//        // Name Label
//        nameLabel = UILabel()
//        nameLabel.textAlignment = .center
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nameLabel)
//
//        // Age Label
//        ageLabel = UILabel()
//        ageLabel.textAlignment = .center
//        ageLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(ageLabel)
//
//        // Gender Label
//        genderLabel = UILabel()
//        genderLabel.textAlignment = .center
//        genderLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(genderLabel)
//
//        // Height Label
//        heightLabel = UILabel()
//        heightLabel.textAlignment = .center
//        heightLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(heightLabel)
//
//        // Activity Level Label
//        activityLevelLabel = UILabel()
//        activityLevelLabel.textAlignment = .center
//        activityLevelLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(activityLevelLabel)
//
//        // Logout Button
//        logoutButton = UIButton(type: .system)
//        logoutButton.setTitle("Logout", for: .normal)
//        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
//        logoutButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(logoutButton)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//
//            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
//
//            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            genderLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
//
//            heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            heightLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
//
//            activityLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityLevelLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20),
//
//            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//    }
//
//    // MARK: - Data Fetching
//
//    private func fetchProfileDetails() {
//        guard let userEmail = Auth.auth().currentUser?.email else {
//            return
//        }
//
//        firestore.collection("profiles").document(userEmail).getDocument { [weak self] snapshot, error in
//            if let error = error {
//                print("Error fetching profile details: \(error.localizedDescription)")
//                return
//            }
//
//            if let data = snapshot?.data(),
//               let name = data["name"] as? String,
//               let age = data["age"] as? String,
//               let gender = data["gender"] as? String,
//               let height = data["height"] as? Float,
//               let activityLevel = data["activityLevel"] as? Int {
//
//                self?.nameLabel.text = "Name: \(name)"
//                self?.ageLabel.text = "Age: \(age)"
//                self?.genderLabel.text = "Gender: \(gender)"
//                self?.heightLabel.text = "Height: \(height) cm"
//                self?.activityLevelLabel.text = "Activity Level: \(activityLevel)"
//            }
//        }
//    }
//
//    // MARK: - Logout Button
//
//    private func addLogoutButton() {
//        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
//        navigationItem.rightBarButtonItem = logoutButton
//    }
//
//    @objc private func logoutButtonTapped() {
//        do {
//            try Auth.auth().signOut()
//            // Redirect to the login screen
//            let loginVC = ViewController()
//            navigationController?.setViewControllers([loginVC], animated: true)
//        } catch {
//            print("Error logging out: \(error.localizedDescription)")
//        }
//    }
//}

//import UIKit
//import FirebaseFirestore
//import FirebaseAuth
//
//class ProfileViewController: UIViewController {
//
//    // MARK: - Properties
//
//    private let firestore = Firestore.firestore()
//
//    private var nameLabel: UILabel!
//    private var ageLabel: UILabel!
//    private var genderLabel: UILabel!
//    private var heightLabel: UILabel!
//    private var activityLevelLabel: UILabel!
//    private var logoutButton: UIButton!
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//        fetchProfileDetails()
//        addLogoutButton()
//    }
//
//    // MARK: - UI Setup
//
//    private func setupUI() {
//        view.backgroundColor = .white
//
//        // Name Label
//        nameLabel = createTitleLabel()
//
//        // Age Label
//        ageLabel = createTitleLabel()
//
//        // Gender Label
//        genderLabel = createTitleLabel()
//
//        // Height Label
//        heightLabel = createTitleLabel()
//
//        // Activity Level Label
//        activityLevelLabel = createTitleLabel()
//
//        // Logout Button
//        logoutButton = UIButton(type: .system)
//        logoutButton.setTitle("Logout", for: .normal)
//        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
//        logoutButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(logoutButton)
//
//        // Stack View
//        let stackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, genderLabel, heightLabel, activityLevelLabel])
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackView)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
//            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//    }
//
//    private func createTitleLabel() -> UILabel {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }
//
//    // MARK: - Data Fetching
//
//    private func fetchProfileDetails() {
//        guard let userEmail = Auth.auth().currentUser?.email else {
//            return
//        }
//
//        firestore.collection("profiles").document(userEmail).getDocument { [weak self] snapshot, error in
//            if let error = error {
//                print("Error fetching profile details: \(error.localizedDescription)")
//                return
//            }
//
//            if let data = snapshot?.data(),
//               let name = data["name"] as? String,
//               let age = data["age"] as? String,
//               let gender = data["gender"] as? String,
//               let height = data["height"] as? Float,
//               let activityLevel = data["activityLevel"] as? Int {
//
//                self?.nameLabel.text = "Name: \(name)"
//                self?.ageLabel.text = "Age: \(age)"
//                self?.genderLabel.text = "Gender: \(gender)"
//                self?.heightLabel.text = "Height: \(height) cm"
//                self?.activityLevelLabel.text = "Activity Level: \(activityLevel)"
//            }
//        }
//    }
//
//    // MARK: - Logout Button
//
//    private func addLogoutButton() {
//        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
//        navigationItem.rightBarButtonItem = logoutButton
//    }
//
//    @objc private func logoutButtonTapped() {
//        do {
//            try Auth.auth().signOut()
//            // Redirect to the login screen
//            let loginVC = ViewController()
//            navigationController?.setViewControllers([loginVC], animated: true)
//        } catch {
//            print("Error logging out: \(error.localizedDescription)")
//        }
//    }
//}

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController {

    // MARK: - Properties
    
    private let firestore = Firestore.firestore()
    
    private var titleLabel: UILabel!
    private var nameLabel: UILabel!
    private var ageLabel: UILabel!
    private var genderLabel: UILabel!
    private var heightLabel: UILabel!
    private var activityLevelLabel: UILabel!
    private var backButton: UIButton!
    private var logoutButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchProfileDetails()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Title Label
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.text = "Your Profile"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Name Label
        nameLabel = createResultLabel()
        
        // Age Label
        ageLabel = createResultLabel()
        
        // Gender Label
        genderLabel = createResultLabel()
        
        // Height Label
        heightLabel = createResultLabel()
        
        // Activity Level Label
        activityLevelLabel = createResultLabel()
        
        // Back Button
        backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        // Logout Button
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        // Stack View
        let stackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, genderLabel, heightLabel, activityLevelLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func createResultLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // MARK: - Data Fetching
    
    private func fetchProfileDetails() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        firestore.collection("profiles").document(userEmail).getDocument { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching profile details: \(error.localizedDescription)")
                return
            }
            
            if let data = snapshot?.data(),
               let name = data["name"] as? String,
               let age = data["age"] as? String,
               let gender = data["gender"] as? String,
               let height = data["height"] as? Float,
               let activityLevel = data["activityLevel"] as? Int {
                
                self?.nameLabel.text = "Name: \(name)"
                self?.ageLabel.text = "Age: \(age)"
                self?.genderLabel.text = "Gender: \(gender)"
                self?.heightLabel.text = "Height: \(String(format: "%.1f", height)) cm"
                self?.activityLevelLabel.text = "Activity Level: \(activityLevel)"
            }
        }
    }
    
    // MARK: - Back Button
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Logout Button
    
    @objc private func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            // Redirect to the login screen
            let loginVC = ViewController()
            navigationController?.setViewControllers([loginVC], animated: true)
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}
