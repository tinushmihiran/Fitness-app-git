//
//  WarmUpListViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-14.
//
//
import UIKit
import Firebase
import WebKit

class WarmUpListViewController: UIViewController {
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    // Data source for the card views
    var Waarmup: [WARMUP] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Fetch the data from Firestore
        db.collection("warmup").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newWARMUP: [WARMUP] = []
                for document in querySnapshot!.documents {
                    let Waarmup = WARMUP(snapshot: document)
                    newWARMUP.append(Waarmup)
                }
                self.Waarmup = newWARMUP
                self.addCardViews()
                print("Fetched \(self.Waarmup.count) WARMUP")
            }
        }
        
        // Add background image to the view
                let backgroundImage = UIImageView(frame: view.bounds)
                backgroundImage.image = UIImage(named: "warmupback")
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
        let selectedWarmUp = Waarmup[index]
        
        let cardDetailsVC = CardDetailsViewController(warmUp: selectedWarmUp)
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
           titleLabel.text = "Warm-up Exercises"
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
        
        for (index, warm) in Waarmup.enumerated() {
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
            
            let nameLabel = UILabel(frame: CGRect(x: 50.0, y: 20.0, width: cardView.frame.width - 70.0, height: 30.0))
            nameLabel.text = warm.name
            nameLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            cardView.addSubview(nameLabel)
            
            let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillEqually
            
            let WarmUpdescriptionLabel = UILabel()
            WarmUpdescriptionLabel.text = "WarmUpdescription: \(warm.WarmUpdescription)"
            WarmUpdescriptionLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(WarmUpdescriptionLabel)
            
            let durationLabel = UILabel()
            durationLabel.text = "duration: \(warm.duration)"
            durationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(durationLabel)
            
            let repetitionsLabel = UILabel()
            repetitionsLabel.text = "repetitions:\(warm.repetitions)"
            repetitionsLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            repetitionsLabel.textAlignment = .left
            stackView.addArrangedSubview(repetitionsLabel)
            
            cardView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
                stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
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


class CardDetailsViewController: UIViewController {

    let warmUp: WARMUP
    let goBackButton = UIButton()
    let webView = WKWebView()

    init(warmUp: WARMUP) {
        self.warmUp = warmUp
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Create and configure the background image view
                let backgroundImage = UIImageView(image: UIImage(named: "warmbg2"))
                backgroundImage.contentMode = .scaleAspectFill
                backgroundImage.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
                    backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
                    backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

        // Create and configure labels
        let nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = UIColor.label
        nameLabel.numberOfLines = 0

        let nameValueLabel = UILabel()
        nameValueLabel.text = warmUp.name
        nameValueLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameValueLabel.textColor = UIColor.label
        nameValueLabel.numberOfLines = 0

        let descriptionTitleLabel = UILabel()
        descriptionTitleLabel.text = "Description:"
        descriptionTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        descriptionTitleLabel.textColor = UIColor.label
        descriptionTitleLabel.numberOfLines = 0

        let descriptionLabel = UILabel()
        descriptionLabel.text = warmUp.WarmUpdescription
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        descriptionLabel.textColor = UIColor.secondaryLabel
        descriptionLabel.numberOfLines = 0

        let durationTitleLabel = UILabel()
        durationTitleLabel.text = "Duration:"
        durationTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        durationTitleLabel.textColor = UIColor.label
        durationTitleLabel.numberOfLines = 0

        let durationLabel = UILabel()
        durationLabel.text = "\(warmUp.duration) seconds"
        durationLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        durationLabel.textColor = UIColor.secondaryLabel

        let repetitionsTitleLabel = UILabel()
        repetitionsTitleLabel.text = "Repetitions:"
        repetitionsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        repetitionsTitleLabel.textColor = UIColor.label
        repetitionsTitleLabel.numberOfLines = 0

        let repetitionsLabel = UILabel()
        repetitionsLabel.text = "\(warmUp.repetitions)"
        repetitionsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        repetitionsLabel.textColor = UIColor.secondaryLabel
        repetitionsLabel.numberOfLines = 0

        // Set up the labels in the view
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            nameValueLabel,
            descriptionTitleLabel,
            descriptionLabel,
            durationTitleLabel,
            durationLabel,
            repetitionsTitleLabel,
            repetitionsLabel
        ])

        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Set up the video view
        if let videoURL = URL(string: warmUp.videoURL) {
            let request = URLRequest(url: videoURL)
            webView.load(request)
            webView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(webView)

            NSLayoutConstraint.activate([
                webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                webView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
                webView.widthAnchor.constraint(equalToConstant: 320), // Adjust the width as needed
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

                view.addSubview(goBackButton)

                NSLayoutConstraint.activate([
                    goBackButton.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 32),
                    goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    goBackButton.heightAnchor.constraint(equalToConstant: 50), // Adjust the height as needed
                    goBackButton.widthAnchor.constraint(equalToConstant: 200) // Adjust the width as needed
                ])
    }

    @objc func goBack() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)

        navigationController?.popViewController(animated: false)
    }
}
