//
//  StopwatchViewController.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-11.
//

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

    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
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
        // Add the backButton to the view
        view.addSubview(backButton)
        
        // Set the constraints for the backButton
        NSLayoutConstraint.activate([
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
        
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
    @objc func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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

