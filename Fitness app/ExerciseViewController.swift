//
//  ExerciseViewController.swift
//  Gym App
//
//  Created by Tinush mihiran on 2023-05-09.
//

import UIKit
import FirebaseFirestore



class ExerciseViewController: UIViewController, UITextFieldDelegate {

    let MealsBtn: UIButton = {
        let MealsBtn = UIButton(type: .system)
        MealsBtn.translatesAutoresizingMaskIntoConstraints = false
        MealsBtn.setTitleColor(.black , for: .normal)
        MealsBtn.setTitle("Meals", for: .normal)
        MealsBtn.addTarget(self, action: #selector(mealsBtntapped), for: .touchUpInside)
        MealsBtn.backgroundColor = .white
        MealsBtn.layer.cornerRadius = 20
        MealsBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return MealsBtn
    }()
    
    
    let StopwatchBtn: UIButton = {
        let StopwatchBtn = UIButton(type: .system)
        StopwatchBtn.translatesAutoresizingMaskIntoConstraints = false
        StopwatchBtn.setTitleColor(.black , for: .normal)
        StopwatchBtn.setTitle("Stopwatch", for: .normal)
        StopwatchBtn.addTarget(self, action: #selector(StopwatchBtntapped), for: .touchUpInside)
        StopwatchBtn.backgroundColor = .white
        StopwatchBtn.layer.cornerRadius = 20
        StopwatchBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return StopwatchBtn
    }()
    
    let RVBtnOne: UIButton = {
        let RVBtnOne = UIButton(type: .system)
        RVBtnOne.translatesAutoresizingMaskIntoConstraints = false
        RVBtnOne.setTitleColor(.white , for: .normal)
        RVBtnOne.setTitle("Warm Up", for: .normal)
       RVBtnOne.addTarget(self, action: #selector(buttonTappedbtn1), for: .touchUpInside)
        RVBtnOne.backgroundColor = .black
        RVBtnOne.layer.cornerRadius = 20
        RVBtnOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return RVBtnOne
    }()


    let RVBtnTwo: UIButton = {
        let RVBtnTwo = UIButton(type: .system)
        RVBtnTwo.translatesAutoresizingMaskIntoConstraints = false
        RVBtnTwo.setTitleColor(.black , for: .normal)
        RVBtnTwo.setTitle("BMI Calculator", for: .normal)
        RVBtnTwo.addTarget(self, action: #selector(BmiTapped), for: .touchUpInside)
        RVBtnTwo.backgroundColor = .white
        RVBtnTwo.layer.cornerRadius = 20
        RVBtnTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return RVBtnTwo
    }()

    
    let RVBtnThree: UIButton = {
        let RVBtnThree = UIButton(type: .system)
        RVBtnThree.translatesAutoresizingMaskIntoConstraints = false
        RVBtnThree.setTitleColor(.white , for: .normal)
        RVBtnThree.setTitle("Exercises", for: .normal)
        RVBtnThree.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        RVBtnThree.backgroundColor = .black
        RVBtnThree.layer.cornerRadius = 20
        RVBtnThree.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return RVBtnThree
    }()
    
    //add firebase firestore
    let database = Firestore.firestore()
    
    //add text label to round view two
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = NSLocalizedString("Popular Exercices", comment: "")
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)

     
        
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
        roundViewOne.backgroundColor = UIColor(white: 0.5, alpha: 0.25)
        stackView.addArrangedSubview(roundViewOne)
        roundViewOne.translatesAutoresizingMaskIntoConstraints = false
        roundViewOne.heightAnchor.constraint(equalToConstant: 400).isActive = true
        roundViewOne.widthAnchor.constraint(equalToConstant: 50).isActive = true
        roundViewOne.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        roundViewOne.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        roundViewOne.layer.cornerRadius = 70
        roundViewOne.layer.masksToBounds = true
        
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
            TitleRoundViewOne.text = NSLocalizedString("Stay Healthy", comment: "")
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
            roundedViewOneSub.translatesAutoresizingMaskIntoConstraints = false
            
            let backgroundImage = UIImage(named: "img1")
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.layer.cornerRadius = 20
            backgroundImageView.clipsToBounds = true
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            roundedViewOneSub.addSubview(backgroundImageView)
            roundedViewOneSub.sendSubviewToBack(backgroundImageView)
            
            NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: roundedViewOneSub.topAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: roundedViewOneSub.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: roundedViewOneSub.trailingAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: roundedViewOneSub.bottomAnchor)
            ])
            
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
        ////////////////////////
        
        let TitleRoundViewOnesub: UILabel = {
            let TitleRoundViewOnesub = UILabel()
            TitleRoundViewOnesub.textColor = .white
            TitleRoundViewOnesub.text = NSLocalizedString("Warm Up", comment: "")
            TitleRoundViewOnesub.font = .systemFont(ofSize: 25)
            TitleRoundViewOnesub.translatesAutoresizingMaskIntoConstraints = false
            return TitleRoundViewOnesub
        }()
        
        roundedViewOneSub.addSubview(TitleRoundViewOnesub)
        roundedViewOneSub.addSubview(RVBtnOne)
        
        //add constrains to text label
        NSLayoutConstraint.activate([
            TitleRoundViewOnesub.widthAnchor.constraint(equalToConstant: 150),
            TitleRoundViewOnesub.heightAnchor.constraint(equalToConstant: 70),
            TitleRoundViewOnesub.leftAnchor.constraint(equalTo: roundedViewOneSub.leftAnchor, constant: 20),
            TitleRoundViewOnesub.rightAnchor.constraint(equalTo: roundedViewOneSub.rightAnchor,constant: 20),
            TitleRoundViewOnesub.topAnchor.constraint(equalTo: roundedViewOneSub.topAnchor, constant: 10)
     

        ])
      
        //////////////////
        // add rounded sub two view to round view one
         
          let roundedViewOneSubTwo: UIView = {
              
              let roundedViewOneSubTwo = UIView()
            roundedViewOneSubTwo.layer.cornerRadius = 30
            roundedViewOneSubTwo.backgroundColor = .white
            roundedViewOneSubTwo.translatesAutoresizingMaskIntoConstraints = false
              //view.alpha = 0.5
            let backgroundImage = UIImage(named: "img2")
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.layer.cornerRadius = 20
            backgroundImageView.clipsToBounds = true
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            roundedViewOneSubTwo.addSubview(backgroundImageView)
            roundedViewOneSubTwo.sendSubviewToBack(backgroundImageView)
            
            NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: roundedViewOneSubTwo.topAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: roundedViewOneSubTwo.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: roundedViewOneSubTwo.trailingAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: roundedViewOneSubTwo.bottomAnchor)
            ])
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
                roundedViewOneSubTwo.addSubview(RVBtnThree)
        ////////////////////////
        
        let TitleRoundViewTwosub: UILabel = {
            let TitleRoundViewTwosub = UILabel()
            TitleRoundViewTwosub.textColor = .white
            TitleRoundViewTwosub.text = NSLocalizedString("All Exercises", comment: "")
            TitleRoundViewTwosub.font = .systemFont(ofSize: 25)
            TitleRoundViewTwosub.translatesAutoresizingMaskIntoConstraints = false
            return TitleRoundViewTwosub
        }()
        
        roundedViewOneSubTwo.addSubview(TitleRoundViewTwosub)
        
        //add constrains to text label
        NSLayoutConstraint.activate([
            TitleRoundViewTwosub.widthAnchor.constraint(equalToConstant: 150),
            TitleRoundViewTwosub.heightAnchor.constraint(equalToConstant: 70),
            TitleRoundViewTwosub.leftAnchor.constraint(equalTo: roundedViewOneSubTwo.leftAnchor, constant: 20),
            TitleRoundViewTwosub.rightAnchor.constraint(equalTo: roundedViewOneSubTwo.rightAnchor,constant: 20),
            TitleRoundViewTwosub.topAnchor.constraint(equalTo: roundedViewOneSubTwo.topAnchor, constant: 10)
     

        ])
      
        //////////////////
        
        
        
        let roundViewTwo = UIView()
        roundViewTwo.backgroundColor = UIColor(white: 0.5, alpha: 0.25)
        stackView.addArrangedSubview(roundViewTwo)
        roundViewTwo.translatesAutoresizingMaskIntoConstraints = false
        roundViewTwo.heightAnchor.constraint(equalToConstant: 400).isActive = true
        roundViewTwo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        roundViewTwo.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        roundViewTwo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        roundViewTwo.layer.cornerRadius = 30
        roundViewTwo.layer.masksToBounds = true


        //btn1 constrains
        NSLayoutConstraint.activate([
            RVBtnOne.widthAnchor.constraint(equalToConstant: 90),
            RVBtnOne.heightAnchor.constraint(equalToConstant: 30),
            RVBtnOne.centerXAnchor.constraint(equalTo: roundedViewOneSub.centerXAnchor),
            RVBtnOne.centerYAnchor.constraint(equalTo: roundedViewOneSub.centerYAnchor)
        ])

      

        
        let TitleRoundViewTwo: UILabel = {
            let TitleRoundViewTwo = UILabel()
            TitleRoundViewTwo.textColor = .white
            TitleRoundViewTwo.text = NSLocalizedString("Activity", comment: "")
            TitleRoundViewTwo.font = .systemFont(ofSize: 25)
            TitleRoundViewTwo.translatesAutoresizingMaskIntoConstraints = false
            return TitleRoundViewTwo
        }()
        
        roundViewTwo.addSubview(TitleRoundViewTwo)
        
        //add constrains to text label
        NSLayoutConstraint.activate([
            TitleRoundViewTwo.widthAnchor.constraint(equalToConstant: 150),
            TitleRoundViewTwo.heightAnchor.constraint(equalToConstant: 70),
            TitleRoundViewTwo.leftAnchor.constraint(equalTo: roundViewTwo.leftAnchor, constant: 20),
            TitleRoundViewTwo.rightAnchor.constraint(equalTo: roundViewTwo.rightAnchor,constant: 20),
            TitleRoundViewTwo.topAnchor.constraint(equalTo: roundViewTwo.topAnchor, constant: 10)
     

        ])
      
      
       
        let docRef = database.document("/Schedules/ScheduleData")
        docRef.addSnapshotListener { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            guard let text = data["text"] as? String else {
                return
            }
            
            DispatchQueue.main.async {
                self?.label.text = text
            }
        }
       
        roundViewTwo.addSubview(label)
        
        //add constrains to text label
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 150),
            label.heightAnchor.constraint(equalToConstant: 70),
            label.leftAnchor.constraint(equalTo: roundViewTwo.leftAnchor, constant: 30),
            label.rightAnchor.constraint(equalTo: roundViewTwo.rightAnchor,constant: 20),
            label.topAnchor.constraint(equalTo: roundViewTwo.topAnchor, constant: 100)
     

        ])
        
        
        
        
        let roundViewThree = UIView()
        roundViewThree.backgroundColor = UIColor(white: 0.5, alpha: 0.25)
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
        
        roundViewThree.addSubview(MealsBtn)
        
        //add constrains to diet meal btn
        NSLayoutConstraint.activate([
            MealsBtn.widthAnchor.constraint(equalToConstant: 90),
            MealsBtn.heightAnchor.constraint(equalToConstant: 30),
            MealsBtn.centerXAnchor.constraint(equalTo: TitleRoundViewThree.centerXAnchor),
            MealsBtn.centerYAnchor.constraint(equalTo: TitleRoundViewThree.centerYAnchor)
        ])

        
        //add round view four
        
        let roundViewFour = UIView()
        roundViewFour.backgroundColor = UIColor(white: 0.5, alpha: 0.25)
        stackView.addArrangedSubview(roundViewFour)
        
        roundViewFour.translatesAutoresizingMaskIntoConstraints = false
        let backgroundImage = UIImage(named: "img1.png")
        let patternColor = UIColor(patternImage: backgroundImage!)
        
        roundViewFour.backgroundColor = patternColor
        roundViewFour.heightAnchor.constraint(equalToConstant: 300).isActive = true
        roundViewFour.widthAnchor.constraint(equalToConstant: 350).isActive = true
        roundViewFour.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        roundViewFour.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        roundViewFour.layer.cornerRadius = 30
        roundViewFour.layer.masksToBounds = true
        
        roundViewFour.addSubview(RVBtnTwo)
            
        //btn2 constrains

        NSLayoutConstraint.activate([
            RVBtnTwo.widthAnchor.constraint(equalToConstant: 90),
            RVBtnTwo.heightAnchor.constraint(equalToConstant: 30),
            RVBtnTwo.centerXAnchor.constraint(equalTo: roundViewFour.centerXAnchor),
            RVBtnTwo.centerYAnchor.constraint(equalTo: roundViewFour.centerYAnchor)
        ])

      
                //btn3 constrains
     
                NSLayoutConstraint.activate([
                    RVBtnThree.widthAnchor.constraint(equalToConstant: 90),
                    RVBtnThree.heightAnchor.constraint(equalToConstant: 30),
                    RVBtnThree.topAnchor.constraint(equalTo: roundedViewOneSubTwo.topAnchor, constant: 100),
                    RVBtnThree.leftAnchor.constraint(equalTo: roundedViewOneSubTwo.leftAnchor, constant: 50)
                ])
        //add text label to round view four
        
        let TitleRoundViewFour: UILabel = {
            let TitleRoundViewFour = UILabel()
            TitleRoundViewFour.textColor = .white
            TitleRoundViewFour.text = NSLocalizedString("BMI Value Measure", comment: "")
            TitleRoundViewFour.font = .systemFont(ofSize: 35)
            TitleRoundViewFour.translatesAutoresizingMaskIntoConstraints = false
            return TitleRoundViewFour
        }()
        
        roundViewFour.addSubview(TitleRoundViewFour)
        
        //add constrains to text label
        NSLayoutConstraint.activate([
            TitleRoundViewFour.widthAnchor.constraint(equalToConstant: 150),
            TitleRoundViewFour.heightAnchor.constraint(equalToConstant: 70),
            TitleRoundViewFour.leftAnchor.constraint(equalTo: roundViewFour.leftAnchor, constant: 20),
            TitleRoundViewFour.rightAnchor.constraint(equalTo: roundViewFour.rightAnchor,constant: 20),
            TitleRoundViewFour.topAnchor.constraint(equalTo: roundViewFour.topAnchor, constant: 10)
     

        ])
        
        
        //add round view five
        
        let roundViewFive = UIView()
        roundViewFive.backgroundColor = UIColor(white: 0.5, alpha: 0.25)
        stackView.addArrangedSubview(roundViewFive)
        roundViewFive.translatesAutoresizingMaskIntoConstraints = false
        roundViewFive.heightAnchor.constraint(equalToConstant: 300).isActive = true
        roundViewFive.widthAnchor.constraint(equalToConstant: 350).isActive = true
        roundViewFive.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        roundViewFive.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        roundViewFive.layer.cornerRadius = 30
        roundViewFive.layer.masksToBounds = true
        
      
        //add text label to round view four
        
        let TitleRoundViewFive: UILabel = {
            let TitleRoundViewFive = UILabel()
            TitleRoundViewFive.textColor = .white
            TitleRoundViewFive.text = NSLocalizedString("Stopwatch", comment: "")
            TitleRoundViewFive.font = .systemFont(ofSize: 35)
            TitleRoundViewFive.translatesAutoresizingMaskIntoConstraints = false
            return TitleRoundViewFive
        }()
        
        roundViewFive.addSubview(TitleRoundViewFive)
        roundViewFive.addSubview(StopwatchBtn)
        //add constrains to text label
        NSLayoutConstraint.activate([
            TitleRoundViewFive.widthAnchor.constraint(equalToConstant: 150),
            TitleRoundViewFive.heightAnchor.constraint(equalToConstant: 70),
            TitleRoundViewFive.leftAnchor.constraint(equalTo: roundViewFive.leftAnchor, constant: 20),
            TitleRoundViewFive.rightAnchor.constraint(equalTo: roundViewFive.rightAnchor,constant: 20),
            TitleRoundViewFive.topAnchor.constraint(equalTo: roundViewFive.topAnchor, constant: 10)
     

        ])
        
        
        //stopwatch btn constrains

        NSLayoutConstraint.activate([
            StopwatchBtn.widthAnchor.constraint(equalToConstant: 90),
            StopwatchBtn.heightAnchor.constraint(equalToConstant: 30),
            StopwatchBtn.centerXAnchor.constraint(equalTo: roundViewFive.centerXAnchor),
            StopwatchBtn.centerYAnchor.constraint(equalTo: roundViewFive.centerYAnchor)
        ])

   
    }
    
    @objc func buttonTapped() {
        let nextViewController = ExerciseListViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
   }
    
    @objc func buttonTappedbtn1() {
        let nextViewController = WarmUpListViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
   }
    
    @objc func BmiTapped() {
        let nextViewController = BMIViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
   }
    
    @objc func StopwatchBtntapped() {
        let nextViewController = StopwatchViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
   }
    
    @objc func mealsBtntapped() {
        let nextViewController = MealsListViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
   }
    
}






