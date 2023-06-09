//
//  MealsListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-14.
//

import UIKit
import Firebase
import WebKit

class MealsListViewController: UIViewController {
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    // Data source for the card views
    var foood: [Foods] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Fetch the data from Firestore
        db.collection("foods").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newFoods: [Foods] = []
                for document in querySnapshot!.documents {
                    let foood = Foods(snapshot: document)
                    newFoods.append(foood)
                }
                self.foood = newFoods
                self.addCardViews()
                print("Fetched \(self.foood.count) Foods")
            }
        }
        
        // Add background image to the view
                let backgroundImage = UIImageView(frame: view.bounds)
                backgroundImage.image = UIImage(named: "RoundViewOne") // Replace "your-background-image" with the actual image name
                backgroundImage.contentMode = .scaleAspectFill
                view.addSubview(backgroundImage)
                view.sendSubviewToBack(backgroundImage)
    }
    
    @objc func goButtonTapped() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)

        navigationController?.popViewController(animated: false)
    }
    
    @objc func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view else { return }
        guard let index = cardView.tag as Int? else { return }
        let selectedfood = foood[index]
        
        let cardDetailsVC = FoodDetailsViewController(food: selectedfood)
        navigationController?.pushViewController(cardDetailsVC, animated: true)
    }
    
    func addCardViews() {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        
      
        
        var yPosition: CGFloat = 100.0
        let contentWidth = view.frame.width - 40.0
        
        // Create a title label
           let titleLabel = UILabel(frame: CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 30.0))
           titleLabel.text = "Healthy Foods"
           titleLabel.textColor = .white
           titleLabel.font = UIFont.systemFont(ofSize: 34.0, weight: .bold)
           scrollView.addSubview(titleLabel)
           yPosition += 50.0
        
        // Create a "Go" button
          let goButton = UIButton(type: .system)
          goButton.setTitle("Go back", for: .normal)
          goButton.setTitleColor(.white, for: .normal)
          goButton.backgroundColor = .systemBlue
          goButton.layer.cornerRadius = 10.0
          goButton.frame = CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 50.0)
          goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
          scrollView.addSubview(goButton)
          yPosition += 70.0
        
        for (index, food) in foood.enumerated() {
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 200.0))
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 10.0
            cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cardView.layer.shadowRadius = 2.0
            cardView.layer.shadowOpacity = 0.2
            
            let titleIcon = UIImageView(image: UIImage(systemName: "circle.fill"))
            titleIcon.tintColor = .systemBlue
            titleIcon.frame = CGRect(x: 20.0, y: 25.0, width: 20.0, height: 20.0)
            cardView.addSubview(titleIcon)
            
            let titleLabel = UILabel(frame: CGRect(x: 50.0, y: 20.0, width: cardView.frame.width - 70.0, height: 30.0))
            titleLabel.text = food.title
            titleLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            cardView.addSubview(titleLabel)
            
            let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillEqually
            
            let ingredientsLabel = UILabel()
            ingredientsLabel.text = "ingredients: \(food.ingredients)"
            ingredientsLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(ingredientsLabel)
            
            let servingsLabel = UILabel()
            servingsLabel.text = "servings: \(food.servings)"
            servingsLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(servingsLabel)
            
            let instructionsLabel = UILabel()
            instructionsLabel.text = "instructions:\(food.instructions)"
            instructionsLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            instructionsLabel.textAlignment = .left
            stackView.addArrangedSubview(instructionsLabel)
            
            cardView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
                stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
                stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10.0)
            ])
            
            let difficultyIcon = UIImageView(image: UIImage(systemName: "bolt.fill"))
            difficultyIcon.tintColor = .systemYellow
            difficultyIcon.frame = CGRect(x: cardView.frame.width - 45.0, y: 25.0, width: 20.0, height: 20.0)
            cardView.addSubview(difficultyIcon)
            
            // Add a tap gesture recognizer to the card view
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
            cardView.addGestureRecognizer(tapGesture)
            cardView.isUserInteractionEnabled = true
            cardView.tag = index
            
            scrollView.addSubview(cardView)
            
            yPosition += 220.0
        }
        
        // Set the content size of the scroll view
        let contentHeight = yPosition + 20.0
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Add the scroll view to the main view
        view.addSubview(scrollView)
    }
}



class FoodDetailsViewController: UIViewController {

    let food: Foods
    let goBackButton = UIButton()
    let webView = WKWebView()
    let scrollView = UIScrollView()
    let contentView = UIView()

    init(food: Foods) {
        self.food = food
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Set up the scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Set up the content view inside the scroll view
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Create and configure labels
        let titleLabel = UILabel()
        titleLabel.text = "Title:"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor.label
        titleLabel.numberOfLines = 0

        let titleLabelContent = UILabel()
        titleLabelContent.text = food.title
        titleLabelContent.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabelContent.textColor = UIColor.label
        titleLabelContent.numberOfLines = 0

        let ingredientsTitleLabel = UILabel()
        ingredientsTitleLabel.text = "Ingredients:"
        ingredientsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        ingredientsTitleLabel.textColor = UIColor.label
        ingredientsTitleLabel.numberOfLines = 0

        let ingredientsLabel = UILabel()
        ingredientsLabel.text = food.ingredients
        ingredientsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        ingredientsLabel.textColor = UIColor.secondaryLabel
        ingredientsLabel.numberOfLines = 0

        let servingsTitleLabel = UILabel()
        servingsTitleLabel.text = "Servings:"
        servingsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        servingsTitleLabel.textColor = UIColor.label
        servingsTitleLabel.numberOfLines = 0

        let servingsLabel = UILabel()
        servingsLabel.text = "\(food.servings)"
        servingsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        servingsLabel.textColor = UIColor.secondaryLabel

        let instructionsTitleLabel = UILabel()
        instructionsTitleLabel.text = "Instructions:"
        instructionsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        instructionsTitleLabel.textColor = UIColor.label
        instructionsTitleLabel.numberOfLines = 0

        let instructionsLabel = UILabel()
        instructionsLabel.text = food.instructions
        instructionsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        instructionsLabel.textColor = UIColor.secondaryLabel
        instructionsLabel.numberOfLines = 0

        // Add labels to the content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleLabelContent)
        contentView.addSubview(ingredientsTitleLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(servingsTitleLabel)
        contentView.addSubview(servingsLabel)
        contentView.addSubview(instructionsTitleLabel)
        contentView.addSubview(instructionsLabel)

        // Set up the labels in the content view
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleLabelContent, ingredientsTitleLabel, ingredientsLabel, servingsTitleLabel, servingsLabel, instructionsTitleLabel, instructionsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        // Set up the video
        if let videoURL = URL(string: food.videoURL) {
            let request = URLRequest(url: videoURL)
            webView.load(request)
            webView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(webView)

            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
                webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                webView.heightAnchor.constraint(equalToConstant: 240) // Adjust the height as needed
            ])
        }

        // Set up the "Go Back" button
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.setTitleColor(UIColor.white, for: .normal)
        goBackButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        goBackButton.backgroundColor = UIColor.black
        goBackButton.layer.cornerRadius = 8
        goBackButton.layer.borderWidth = 2
        goBackButton.layer.borderColor = UIColor.white.cgColor
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(goBackButton)

        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16),
            goBackButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            goBackButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            goBackButton.heightAnchor.constraint(equalToConstant: 50),
            goBackButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
