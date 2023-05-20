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
//class ProfileViewController: UIViewController {
//
//    // MARK: - Properties
//
//    private let firestore = Firestore.firestore()
//
//    private var titleLabel: UILabel!
//    private var nameLabel: UILabel!
//    private var ageLabel: UILabel!
//    private var genderLabel: UILabel!
//    private var heightLabel: UILabel!
//    private var activityLevelLabel: UILabel!
//    private var backButton: UIButton!
//    private var logoutButton: UIButton!
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//        fetchProfileDetails()
//    }
//
//    // MARK: - UI Setup
//
//    private func setupUI() {
//        view.backgroundColor = .white
//
//        // Title Label
//        titleLabel = UILabel()
//        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        titleLabel.text = "Your Profile"
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(titleLabel)
//
//        // Name Label
//        nameLabel = createResultLabel()
//
//        // Age Label
//        ageLabel = createResultLabel()
//
//        // Gender Label
//        genderLabel = createResultLabel()
//
//        // Height Label
//        heightLabel = createResultLabel()
//
//        // Activity Level Label
//        activityLevelLabel = createResultLabel()
//
//        // Back Button
//        backButton = UIButton(type: .system)
//        backButton.setTitle("Back", for: .normal)
//        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(backButton)
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
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackView)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//
//            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//
//            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//    }
//
//    private func createResultLabel() -> UILabel {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18)
//        label.textAlignment = .left
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
//                self?.heightLabel.text = "Height: \(String(format: "%.1f", height)) cm"
//                self?.activityLevelLabel.text = "Activity Level: \(activityLevel)"
//            }
//        }
//    }
//
//    // MARK: - Back Button
//
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//
//    // MARK: - Logout Button
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
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "stopwatch")
                backgroundImage.contentMode = .scaleAspectFill
                view.insertSubview(backgroundImage, at: 0)
                
        // CardView
        let cardView = UIView()
        cardView.backgroundColor = .gray
        cardView.layer.cornerRadius = 10
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        
        // Title Label
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.text = "Your Profile"
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)
        
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
        backButton.backgroundColor = .black
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 5
        cardView.addSubview(backButton)
        
        // Logout Button
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.backgroundColor = .systemRed
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 5
        cardView.addSubview(logoutButton)
        
        // Stack View
        let stackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, genderLabel, heightLabel, activityLevelLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20),
            
            backButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            logoutButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            logoutButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func createResultLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .white
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
