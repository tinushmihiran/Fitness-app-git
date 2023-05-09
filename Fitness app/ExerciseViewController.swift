//
//  ExerciseViewController.swift
//  Gym App
//
//  Created by Tinush mihiran on 2023-05-09.
//

import UIKit

class ExerciseViewController: UIViewController {

    
    let RVBtnOne: UIButton = {
        let RVBtnOne = UIButton(type: .system)
        RVBtnOne.translatesAutoresizingMaskIntoConstraints = false
        RVBtnOne.setTitleColor(.black , for: .normal)
        RVBtnOne.setTitle("Warm Up", for: .normal)
        //RVBtnOne.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        RVBtnOne.backgroundColor = .white
        RVBtnOne.layer.cornerRadius = 20
        RVBtnOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return RVBtnOne
    }()
    
    
    
    let RVBtnTwo: UIButton = {
        let RVBtnTwo = UIButton(type: .system)
        RVBtnTwo.translatesAutoresizingMaskIntoConstraints = false
        RVBtnTwo.setTitleColor(.black , for: .normal)
        RVBtnTwo.setTitle("Normal", for: .normal)
        //RVBtnOne.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        RVBtnTwo.backgroundColor = .white
        RVBtnTwo.layer.cornerRadius = 20
        RVBtnTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return RVBtnTwo
    }()
    
    
    let RVBtnThree: UIButton = {
        let RVBtnThree = UIButton(type: .system)
        RVBtnThree.translatesAutoresizingMaskIntoConstraints = false
        RVBtnThree.setTitleColor(.black , for: .normal)
        RVBtnThree.setTitle("Hard", for: .normal)
        //RVBtnOne.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        RVBtnThree.backgroundColor = .white
        RVBtnThree.layer.cornerRadius = 20
        RVBtnThree.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return RVBtnThree
    }()
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Create an instance of UIImageView
           let backgroundImageView = UIImageView(frame: self.view.bounds)

           // Set the image property of the UIImageView
           backgroundImageView.image = UIImage(named: "img2")

           // Set the content mode to scale the image to fit the view's bounds
           backgroundImageView.contentMode = .scaleAspectFill

           // Add the UIImageView as a subview of the view controller's view
           self.view.addSubview(backgroundImageView)

           // Send the UIImageView to the back so that it appears behind the other views
           self.view.sendSubviewToBack(backgroundImageView)
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let stackView = UIStackView()
        stackView.spacing = 70
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 150).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
       
        
        let roundViewOne = UIView()
        roundViewOne.backgroundColor = .black
        stackView.addArrangedSubview(roundViewOne)
        roundViewOne.translatesAutoresizingMaskIntoConstraints = false
        roundViewOne.heightAnchor.constraint(equalToConstant: 400).isActive = true
        roundViewOne.widthAnchor.constraint(equalToConstant: 50).isActive = true
        roundViewOne.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        roundViewOne.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        roundViewOne.layer.cornerRadius = 70
        roundViewOne.layer.masksToBounds = true
        backgroundImageView.alpha = 0.99
        
        //add text label to scroll view
        
        let NameLabel: UILabel = {
            let NameLabel = UILabel()
            NameLabel.textColor = .white
            NameLabel.text = NSLocalizedString("Hi,Tinush", comment: "")
            NameLabel.font = .systemFont(ofSize: 35)
            NameLabel.translatesAutoresizingMaskIntoConstraints = false
            return NameLabel
        }()
        
        scrollView.addSubview(NameLabel)
        
        //add constrains to name label
        NSLayoutConstraint.activate([
            NameLabel.widthAnchor.constraint(equalToConstant:300),
            NameLabel.heightAnchor.constraint(equalToConstant: 30),
            NameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            NameLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor,constant: 20),
            NameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50)
     

        ])
        
        //add text label to scroll view slogan text
        
        let SloganLabel: UILabel = {
            let SloganLabel = UILabel()
            SloganLabel.textColor = .white
            SloganLabel.text = NSLocalizedString("Ready To Workout", comment: "")
            SloganLabel.font = .systemFont(ofSize: 20)
            SloganLabel.translatesAutoresizingMaskIntoConstraints = false
            return SloganLabel
        }()
        
        scrollView.addSubview(SloganLabel)
        
        //add constrains to slogan label
        NSLayoutConstraint.activate([
            SloganLabel.widthAnchor.constraint(equalToConstant:300),
            SloganLabel.heightAnchor.constraint(equalToConstant: 20),
            SloganLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            SloganLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor,constant: 20),
            SloganLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:90)
     

        ])
        
        //add text label to round view one
        
        let TitleRoundViewOne: UILabel = {
            let TitleRoundViewOne = UILabel()
            TitleRoundViewOne.textColor = .white
            TitleRoundViewOne.text = NSLocalizedString("Popular Exercices", comment: "")
            TitleRoundViewOne.font = .systemFont(ofSize: 35)
            TitleRoundViewOne.translatesAutoresizingMaskIntoConstraints = false
            return TitleRoundViewOne
        }()
        
        roundViewOne.addSubview(TitleRoundViewOne)
        
        //add constrains to text label
        NSLayoutConstraint.activate([
            TitleRoundViewOne.widthAnchor.constraint(equalToConstant: 150),
            TitleRoundViewOne.heightAnchor.constraint(equalToConstant: 70),
            TitleRoundViewOne.leftAnchor.constraint(equalTo: roundViewOne.leftAnchor, constant: 50),
            TitleRoundViewOne.rightAnchor.constraint(equalTo: roundViewOne.rightAnchor,constant: 20),
            TitleRoundViewOne.topAnchor.constraint(equalTo: roundViewOne.topAnchor, constant: 10)
     

        ])

      // add rounded sub view to round view one
       
        let roundedViewOneSub: UIView = {
            
            let roundedViewOneSub = UIView()
            roundedViewOneSub.layer.cornerRadius = 30
            roundedViewOneSub.backgroundColor = .white
            roundedViewOneSub.translatesAutoresizingMaskIntoConstraints = false
            //view.alpha = 0.5
            return roundedViewOneSub
           
        }()
        
        roundViewOne.addSubview(roundedViewOneSub)
        
        
        // sub roundview one constrains
             NSLayoutConstraint.activate([
                 roundedViewOneSub.widthAnchor.constraint(equalToConstant: 150),
                 roundedViewOneSub.heightAnchor.constraint(equalToConstant: 250),
                 roundedViewOneSub.leftAnchor.constraint(equalTo: roundViewOne.leftAnchor, constant: 20),
                roundViewOne.rightAnchor.constraint(equalTo: roundViewOne.rightAnchor,constant: 20),
                 roundedViewOneSub.topAnchor.constraint(equalTo: roundViewOne.topAnchor, constant: 100)
            
             ])
        
        
      
        
        // add rounded sub view to round view two
         
          let roundedViewOneSubTwo: UIView = {
              
              let roundedViewOneSubTwo = UIView()
            roundedViewOneSubTwo.layer.cornerRadius = 30
            roundedViewOneSubTwo.backgroundColor = .white
            roundedViewOneSubTwo.translatesAutoresizingMaskIntoConstraints = false
              //view.alpha = 0.5
              return roundedViewOneSubTwo
             
          }()
          
          roundViewOne.addSubview(roundedViewOneSubTwo)
          
          
          // sub roundview Two constrains
               NSLayoutConstraint.activate([
                roundedViewOneSubTwo.widthAnchor.constraint(equalToConstant: 150),
                roundedViewOneSubTwo.heightAnchor.constraint(equalToConstant: 250),
                roundedViewOneSubTwo.leftAnchor.constraint(equalTo: roundViewOne.leftAnchor, constant: 190),
                roundedViewOneSubTwo.rightAnchor.constraint(equalTo: roundViewOne.rightAnchor,constant: -20),
                roundedViewOneSubTwo.topAnchor.constraint(equalTo: roundViewOne.topAnchor, constant: 100)
              
               ])
          
        
        
        
        
        let roundViewTwo = UIView()
        roundViewTwo.backgroundColor = .black
        stackView.addArrangedSubview(roundViewTwo)
        roundViewTwo.translatesAutoresizingMaskIntoConstraints = false
        roundViewTwo.heightAnchor.constraint(equalToConstant: 400).isActive = true
        roundViewTwo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        roundViewTwo.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        roundViewTwo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        roundViewTwo.layer.cornerRadius = 30
        roundViewTwo.layer.masksToBounds = true

        
        roundViewTwo.addSubview(RVBtnOne)
        roundViewTwo.addSubview(RVBtnTwo)
        roundViewTwo.addSubview(RVBtnThree)
        
        
        
       
             
        
        
        //btn1 constrains
        
        NSLayoutConstraint.activate([
            RVBtnOne.widthAnchor.constraint(equalToConstant: 90),
            RVBtnOne.heightAnchor.constraint(equalToConstant: 30),
            RVBtnOne.topAnchor.constraint(equalTo: roundViewTwo.topAnchor, constant: 20),
            RVBtnOne.leftAnchor.constraint(equalTo: roundViewTwo.leftAnchor, constant: 20)
        ])
        
        //btn2 constrains
        
        NSLayoutConstraint.activate([
            RVBtnTwo.widthAnchor.constraint(equalToConstant: 90),
            RVBtnTwo.heightAnchor.constraint(equalToConstant: 30),
            RVBtnTwo.topAnchor.constraint(equalTo: roundViewTwo.topAnchor, constant: 20),
            RVBtnTwo.leftAnchor.constraint(equalTo: roundViewTwo.leftAnchor, constant: 130)
        ])
        
        
        //btn3 constrains
        
        NSLayoutConstraint.activate([
            RVBtnThree.widthAnchor.constraint(equalToConstant: 90),
            RVBtnThree.heightAnchor.constraint(equalToConstant: 30),
            RVBtnThree.topAnchor.constraint(equalTo: roundViewTwo.topAnchor, constant: 20),
            RVBtnThree.leftAnchor.constraint(equalTo: roundViewTwo.leftAnchor, constant: 240)
        ])
      
        
        
        
        let roundViewThree = UIView()
        roundViewThree.backgroundColor = .black
        stackView.addArrangedSubview(roundViewThree)
        roundViewThree.translatesAutoresizingMaskIntoConstraints = false
        roundViewThree.heightAnchor.constraint(equalToConstant: 500).isActive = true
        roundViewThree.widthAnchor.constraint(equalToConstant: 350).isActive = true
        roundViewThree.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        roundViewThree.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        roundViewThree.layer.cornerRadius = 30
        roundViewThree.layer.masksToBounds = true
        
      
        //add text label to round view Three
        
        let TitleRoundViewThree: UILabel = {
            let TitleRoundViewThree = UILabel()
            TitleRoundViewThree.textColor = .white
            TitleRoundViewThree.text = NSLocalizedString("Diet Meals", comment: "")
            TitleRoundViewThree.font = .systemFont(ofSize: 35)
            TitleRoundViewThree.translatesAutoresizingMaskIntoConstraints = false
            return TitleRoundViewThree
        }()
        
        roundViewThree.addSubview(TitleRoundViewThree)
        
        //add constrains to text label
        NSLayoutConstraint.activate([
            TitleRoundViewThree.widthAnchor.constraint(equalToConstant: 150),
            TitleRoundViewThree.heightAnchor.constraint(equalToConstant: 70),
            TitleRoundViewThree.leftAnchor.constraint(equalTo: roundViewThree.leftAnchor, constant: 20),
            TitleRoundViewThree.rightAnchor.constraint(equalTo: roundViewThree.rightAnchor,constant: 20),
            TitleRoundViewThree.topAnchor.constraint(equalTo: roundViewThree.topAnchor, constant: 10)
     

        ])
        
        
        
        
        
        
        
    }
}






