//
//  ProgressBarBubbleView.swift
//  ProgressBarBubbleView
//
//  Created by Tan Nghia La on 12.05.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import Foundation
import UIKit

final class ProgressBarBubbleView: UIView {
    // MARK: - Properties
    private let bubbleView = BubbleView()
    private let barView = BarView()
    
    var textColor: UIColor {
        get {
            return bubbleView.textColor
        }
        set {
            bubbleView.textColor = newValue
        }
    }
    
    var font: UIFont {
        get {
            return bubbleView.font
        }
        set {
            bubbleView.font = newValue
        }
    }
    
    var bubbleBackgroundColor: UIColor? {
        get {
            return bubbleView.bubbleBackgroundColor
        }        
        set {
            bubbleView.bubbleBackgroundColor = newValue
        }
    }
    
    var progressColors: [CGColor] {
        get {
            return barView.progressColors
        }
        set {
            barView.progressColors = newValue
        }
    }
    
    var thresholdReachedColors: [CGColor] {
        get {
            return barView.thresholdReachedColors
        }
        set {
            barView.thresholdReachedColors = newValue
        }
    }
    
    // MARK: - Init
    init(bubbleHeight: CGFloat = 40, barHeight: CGFloat = 10) {
        super.init(frame: CGRectZero)
        
        configureView()
        configureConstraints(bubbleHeight, barHeight: barHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    private func configureView() {
        addSubview(bubbleView)
        addSubview(barView)
    }
    
    private func configureConstraints(bubbleHeight: CGFloat, barHeight: CGFloat) {
        barView.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = [
            "barView": barView,
            "bubbleView": bubbleView
        ]
        
        let metrics: [String: CGFloat] = [
            "bubbleHeight": bubbleHeight,
            "barHeight": barHeight
        ]
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[barView]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[bubbleView]|", options: [], metrics: nil, views: views)
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[bubbleView(bubbleHeight)]-5-[barView(barHeight)]|", options: [], metrics: metrics, views: views)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func configure(value: Int, threshold: Int) {
        bubbleView.configure(withViewModel: BubbleView.Model(value: value, threshold: threshold))
        barView.configure(withViewModel: BarView.Model(value: value, threshold: threshold))
    }
}