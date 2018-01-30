//
//  ViewController.swift
//  TheSeconds
//
//  Created by Edoardo de Cal on 15/06/17.
//  Copyright © 2017 Edoardo de Cal. All rights reserved.
/////

import UIKit
import SAConfettiView

class ViewController: UIViewController {
    
    var score = 0 {
        didSet {
            if score > best {
                best = score
            }
        }
    }
    
    var best = UserDefaults.standard.integer(forKey: "bestScore") {
        didSet {
            UserDefaults.standard.set(best, forKey: "bestScore")
        }
    }
    
    var timer = Timer()
    var timeIntervalIce = Timer()
    var seconds = 0
    var milliseconds = 0
    var suffix = 0
    var isTimerRunning = false
    var isTimerRunningIce = false
    var confettiView: SAConfettiView!
    var containerViewController: ContainerController?
    var durationRotate = 0.9
    var count = 1
    var prova = true
    let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    let trackLayer = CAShapeLayer()
    let bestDefault = UserDefaults.standard
    var radiusCircle = CGFloat(0)

    @IBAction func buttonShop(_ sender: Any) {
        timer.invalidate()
        startStopButton.setTitle("Start", for: .normal)
        milliseconds = 0
        seconds = 0
    }
    
    @IBOutlet weak var backGroundImage: UIImageView!
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
    func shouldShowOverlayEffect(image: UIImage, isHidden: Bool) {
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
            self.durationRotate = 3
            self.rotate()
            
            if isTimerRunning == true {
                timeIntervalIce = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(intervalTime) , userInfo: nil, repeats: true)
            }
        }else{
            normalRun()
        }
    }
    
    @objc func intervalTime() {
        durationRotate = 0.9
        timeIntervalIce.invalidate()
        isTimerRunningIce = false
        buttonTapped()
        normalRun()
    }

    
    func buttonTapped() {
    /*
        
        if prova == true {
            startProgressCircle()
        }else{
            pauseAnimation()
            prova = true
        }
        if isTimerRunning {
            ////Timer stops
            isTimerRunning = false
            timeIntervalIce.invalidate()
            isTimerRunningIce = false
            self.stopAnimationForView(self.imageWood)
            self.durationRotate = 0.9
            self.rotate()
            confettiView.stopConfetti()
            buttonViewIce.isUserInteractionEnabled = false
            startStopButton.setTitle("Start", for: .normal)
            self.stopAnimationForView(self.imageWood)
            if seconds >= 1 && suffix == 0 {
                score += 1
                labelUpdate()
            }else{
                labelUpdate()
                if best < score {
                    best = score
                    labelUpdate()
                    bestDefault.set(score, forKey: "best")
                    confettiView.startConfetti()
                }
                score = 0
                labelUpdate()
                milliseconds = 0
            }
            timer.invalidate()
            count = 0
        }else{
            timer.invalidate()
            count = 0
            timeIntervalIce.invalidate()
            isTimerRunningIce = false
            isTimerRunning = true
            shouldShowOverlayEffect(image: #imageLiteral(resourceName: "ScreenIced"), isHidden: true)
            startStopButton.setTitle("Stop", for: .normal)
            rotate()
            buttonViewIce.isUserInteractionEnabled = true
            timer = Timer(timeInterval: 0.01, repeats: true, block: { (_) in
                self.incrementMiliseconds()
                self.count += 1
                if self.count == 101 {
                    self.count = 1
                    self.startProgressCircle()
                }
            })
            RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
 
        }*/
    }
        
    func normalRun() {
        isTimerRunning = true
        timeIntervalIce.invalidate()
        shouldShowOverlayEffect(image: #imageLiteral(resourceName: "ScreenIced"), isHidden: true)
        milliseconds = 0
        startStopButton.setTitle("Stop", for: .normal)
        rotate()
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
    
    func rotate() {
        rotationAnimation.toValue = NSNumber(value: .pi * 3.5)
        rotationAnimation.duration = Double(durationRotate);
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
    }
}
