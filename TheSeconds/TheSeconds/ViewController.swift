//
//  ViewController.swift
//  TheSeconds
//
//  Created by Edoardo de Cal on 15/06/17.
//  Copyright © 2017 Edoardo de Cal. All rights reserved.
/////

import UIKit
import SAConfettiView
import SwiftyTimer

class ViewController: UIViewController {
    var timer = Timer()
    var seconds = 0
    var milliseconds = 0
    var score = 0
    var suffix = 0
    var best = 0
    var isTimerRunning = false
    var isTimerRunningIce = false
    var confettiView: SAConfettiView!
    let bestDefault = UserDefaults.standard
    var speed = 5
    var containerViewController: ContainerController?
    var timeIntervalIce = Timer()
    var durationRuotate = 0.9
    let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    @IBOutlet weak var labelRecord: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var leafScore: UIImageView!
    @IBOutlet weak var imageWood: UIImageView!
    @IBOutlet weak var leafBest: UIImageView!
    @IBAction func startStopButtonTapped(_ sender: Any) {
        buttonTapped()
    }
    @IBOutlet weak var buttonViewIce: UIButton!
    internal func shouldShowOverlayEffect(image: UIImage, isHidden: Bool) {
        containerViewController?.overlayEffectImageView.isHidden = isHidden
    }
    @IBAction func buttonIceTapped(_ sender: Any) {
        if isTimerRunning == true {
            shouldShowOverlayEffect(image: #imageLiteral(resourceName: "ScreenIced"), isHidden: false)
            isTimerRunningIce = true
            timer.invalidate()
            timer = Timer(timeInterval: 0.1, repeats: true, block: { (_) in
                self.incrementMiliseconds()
            })
            RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
            buttonViewIce.isUserInteractionEnabled = false
            self.stopAnimationForView(self.imageWood)
            self.durationRuotate = 3
            self.ruotate()
            if isTimerRunning == true {
                timeIntervalIce = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(intervalTime) , userInfo: nil, repeats: true)}
        }else{
            normalRun()
        }
    }
    
    func intervalTime() {
            durationRuotate = 0.9
            timeIntervalIce.invalidate()
            isTimerRunningIce = false
            buttonTapped()
            normalRun()
    }
    
    func buttonTapped() {
        if isTimerRunning {
            isTimerRunning = false
            timeIntervalIce.invalidate()
            isTimerRunningIce = false
            self.stopAnimationForView(self.imageWood)
            self.durationRuotate = 0.9
            self.ruotate()
            buttonViewIce.isUserInteractionEnabled = false
            startStopButton.setTitle("Start", for: .normal)
            self.stopAnimationForView(self.imageWood)
            print(best)
            if seconds >= 1 && suffix == 0{
                score += 1
                labelUpdate()
            }else{
                print("You lose")
                labelUpdate()
                if best < score {
                    best = score
                    print("ciao")
                    labelUpdate()
                    bestDefault.set(score, forKey: "best")
                }
                score = 0
                labelUpdate()
                milliseconds = 0
            }
            timer.invalidate()
        } else {
            timeIntervalIce.invalidate()
            isTimerRunningIce = false
            isTimerRunning = true
            shouldShowOverlayEffect(image: #imageLiteral(resourceName: "ScreenIced"), isHidden: true)
            startStopButton.setTitle("Stop", for: .normal)
            ruotate()
            buttonViewIce.isUserInteractionEnabled = true
            timer = Timer(timeInterval: 0.01, repeats: true, block: { (_) in
                self.incrementMiliseconds()
            })
            RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        }
    }
    
    func normalRun() {
        isTimerRunning = true
        timeIntervalIce.invalidate()
        shouldShowOverlayEffect(image: #imageLiteral(resourceName: "ScreenIced"), isHidden: true)
        milliseconds = 0
        startStopButton.setTitle("Stop", for: .normal)
        ruotate()
        buttonViewIce.isUserInteractionEnabled = true
        timer = Timer(timeInterval: 0.01, repeats: true, block: { (_) in
            self.incrementMiliseconds()
        })
        RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func display(miliseconds: Int) {
        seconds = miliseconds / 100
        suffix = miliseconds - (seconds * 100)
        if suffix < 10 {
            labelTimer.text = String(seconds) + ".0" + String(suffix)
        } else {
            labelTimer.text = String(seconds) + "." + String(suffix)
        }
    }
    
    func incrementMiliseconds() {
        milliseconds += 1
        display(miliseconds: milliseconds)
    }
    
    func labelUpdate() {
        labelScore.text = "Score: \(score)"
        labelRecord.text = "Best: \(best)"
    }
    
    func setupButtonAndLabel() {
        startStopButton.layer.shadowOpacity = 0.2
        startStopButton.layer.shadowColor = UIColor.black.cgColor
        startStopButton.layer.shadowRadius = 4
        startStopButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        startStopButton.layer.masksToBounds =  false
    }
    
    func setupConfetti() {
        self.confettiView = SAConfettiView(frame: self.view.bounds)
        self.view.addSubview(confettiView)
        confettiView.type = .image(UIImage(named: "ConfettiLeaf")!)
        confettiView.isUserInteractionEnabled = false
    }
    
    func setupLabels() {
        labelScore.transform = CGAffineTransform(rotationAngle: 270)
        labelRecord.transform = CGAffineTransform(rotationAngle: -50)
    }
    
    func ruotate() {
        rotationAnimation.toValue = NSNumber(value: .pi * 3.5)
        rotationAnimation.duration = Double(durationRuotate);
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        self.imageWood?.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopAnimationForView(_ myView: UIView) {
        let transform = myView.layer.presentation()?.transform
        myView.layer.transform = transform!
        myView.layer.removeAllAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfetti()
        setupLabels()
        best = bestDefault.integer(forKey: "best")
        shouldShowOverlayEffect(image: #imageLiteral(resourceName: "ScreenIced"), isHidden: true)
        setupLabels()
        labelUpdate()
        buttonViewIce.isUserInteractionEnabled = false
        print(best)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
}
