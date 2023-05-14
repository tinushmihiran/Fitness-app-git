//
//  StopwatchViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-11.
//

//import UIKit
//
//class StopwatchViewController: UIViewController {
//
//    let timerLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "00:00:00"
//        return label
//    }()
//
//    let startButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Start", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        return button
//    }()
//
//    let stopButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Stop", for: .normal)
//        button.setTitleColor(.red, for: .normal)
//        return button
//    }()
//
//    let resetButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Reset", for: .normal)
//        button.setTitleColor(.gray, for: .normal)
//        return button
//    }()
//
//    var timer = Timer()
//    var elapsedTime: Double = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        view.addSubview(timerLabel)
//        view.addSubview(startButton)
//        view.addSubview(stopButton)
//        view.addSubview(resetButton)
//
//        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
//        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
//        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
//
//        NSLayoutConstraint.activate([
//            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
//
//            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
//            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            stopButton.topAnchor.constraint(equalTo: startButton.topAnchor),
//            stopButton.leadingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: 20),
//
//            resetButton.topAnchor.constraint(equalTo: startButton.topAnchor),
//            resetButton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor, constant: 20),
//            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
//    }
//
//    @objc func startButtonTapped(_ sender: Any) {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            self.elapsedTime += 1
//            self.updateTimerLabel()
//        }
//    }
//
//    @objc func stopButtonTapped(_ sender: Any) {
//        timer.invalidate()
//    }
//
//    @objc func resetButtonTapped(_ sender: Any) {
//        elapsedTime = 0
//        timerLabel.text = "00:00:00"
//    }
//
//    func updateTimerLabel() {
//        let minutes = Int(elapsedTime / 60)
//        let seconds = Int(elapsedTime) % 60
//        let milliseconds = Int(elapsedTime * 1000) % 1000
//
//        timerLabel.text = String(format: "%02d:%02d:%03d", minutes, seconds, milliseconds)
//    }
//}


import UIKit

class StopwatchViewController: UIViewController {

    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00:00.00"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 64, weight: .medium)
        return label
    }()

    let startStopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return button
    }()

    let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return button
    }()

    var timer = Timer()
    var startTime: TimeInterval = 0
    var elapsedTime: TimeInterval = 0
    var isRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(timerLabel)
        view.addSubview(startStopButton)
        view.addSubview(resetButton)

        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),

            startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40),

            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
    }

    @objc func startStopButtonTapped(_ sender: Any) {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }

    @objc func resetButtonTapped(_ sender: Any) {
        stopTimer()
        elapsedTime = 0
        updateTimerLabel()
    }

    func startTimer() {
        isRunning = true
        startTime = Date().timeIntervalSinceReferenceDate - elapsedTime
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.setTitleColor(.systemRed, for: .normal)
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.elapsedTime = Date().timeIntervalSinceReferenceDate - self.startTime
            self.updateTimerLabel()
        }
    }

    func stopTimer() {
        isRunning = false
        timer.invalidate()
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(.systemGreen, for: .normal)
    }

    func updateTimerLabel() {
        let minutes = Int(elapsedTime / 60)
        let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((elapsedTime * 100).truncatingRemainder(dividingBy: 100))

        timerLabel.text = String(format: "%02d:%02d:%02d.%02d", minutes, seconds, Int(elapsedTime), milliseconds)
    }
}

