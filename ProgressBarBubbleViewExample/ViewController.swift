//
//  ViewController.swift
//  ProgressBarBubbleView
//
//  Created by Tan Nghia La on 12.05.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let progressBarBubbleView = ProgressBarBubbleView(bubbleHeight: 40, barHeight: 10)
    
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    private let basketValueLabel = UILabel()
    
    private var basketValue: Int = 0
    private var threshold: Int = 4000
    
    var randomNumber: Int {
        let lower : UInt32 = 50
        let upper : UInt32 = 400
        return Int(arc4random_uniform(upper - lower) + lower)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureConstraints()
    }
    
    func configureView() {
        view.backgroundColor = UIColor(red: 204 / 255, green: 204 / 255, blue: 204 / 255, alpha: 1)
        view.addSubview(progressBarBubbleView)
        
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        
        view.addSubview(basketValueLabel)
        
        basketValueLabel.contentMode = .Center
        
        plusButton.setTitle("plus", forState: .Normal)
        minusButton.setTitle("minus", forState: .Normal)
        
        plusButton.backgroundColor = .blackColor()
        minusButton.backgroundColor = .blackColor()
        
        plusButton.addTarget(self, action: #selector(ViewController.add), forControlEvents: .TouchUpInside)
        minusButton.addTarget(self, action: #selector(ViewController.minus), forControlEvents: .TouchUpInside)
        
        basketValueLabel.text = "value: " + String(basketValue) + " // threshold: " + String(threshold)
        
        progressBarBubbleView.bubbleBackgroundColor = UIColor(red: 29 / 255, green: 151 / 255, blue: 227 / 255, alpha: 1)
        progressBarBubbleView.configure(basketValue, threshold: threshold)
    }
    
    func configureConstraints() {
        progressBarBubbleView.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        basketValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = [
            "progressBarBubbleView": progressBarBubbleView,
            "plusButton": plusButton,
            "minusButton": minusButton,
            "basketValueLabel": basketValueLabel
        ]
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[progressBarBubbleView]-50-|", options: [], metrics: nil, views: views)
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[basketValueLabel]-50-[progressBarBubbleView]->=0-|", options: [], metrics: nil, views: views)
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[minusButton(100)]->=0-[plusButton(100)]-50-|", options: [], metrics: nil, views: views)
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[plusButton(50)]-100-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[minusButton(50)]-100-|", options: [], metrics: nil, views: views)
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[basketValueLabel]-50-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func add() {
        basketValue += randomNumber
        
        progressBarBubbleView.configure(basketValue, threshold: threshold)
        basketValueLabel.text = "value: " + String(basketValue) + " // threshold: " + String(threshold)
    }
    
    func minus() {
        basketValue -= randomNumber
        
        if basketValue < 0 {
            basketValue = 0
        }
        
        progressBarBubbleView.configure(basketValue, threshold: threshold)
        basketValueLabel.text = "value: " + String(basketValue) + " // threshold: " + String(threshold)
    }
}

