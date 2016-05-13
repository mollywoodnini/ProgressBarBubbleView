//
//  ProgressBarBubbleView+BarView.swift
//  ProgressBarBubbleView
//
//  Created by Tan Nghia La on 12.05.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import Foundation
import UIKit

extension ProgressBarBubbleView {
    final class BarView: UIView {
        // MARK: - Properties
        private let progressView = UIView()
        private let gradientLayer = CAGradientLayer()
        
        var thresholdReachedColors = [UIColor(red: 111 / 255, green: 189 / 255, blue: 20 / 255, alpha: 1).CGColor, UIColor(red: 69 / 255, green: 178 / 255, blue: 26 / 255, alpha: 1).CGColor]
        
        var progressColors = [UIColor(red: 250 / 255, green: 217 / 255, blue: 97 / 255, alpha: 1).CGColor, UIColor(red: 247 / 255, green: 107 / 255, blue: 28 / 255, alpha: 1).CGColor]
        
        // MARK: - Init
        init() {
            super.init(frame: CGRectZero)
            
            configureView()
            configureConstraints()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func drawRect(rect: CGRect) {
            super.drawRect(rect)
            
            let cornerRadius = rect.height / 2
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
            progressView.layer.cornerRadius = cornerRadius
            progressView.layer.masksToBounds = true
        }
        
        // MARK: - View configuration
        private func configureView() {
            addSubview(progressView)
            backgroundColor = .whiteColor()
            
            progressView.layer.insertSublayer(gradientLayer, atIndex: 0)
        }
        
        private func configureConstraints() {
            progressView.translatesAutoresizingMaskIntoConstraints = false
            
            var views: [String: UIView] = [
                "progressView": progressView
            ]
            
            var constraints: [NSLayoutConstraint] = []
            
            var blockFormatString = "H:|"
            let blockCount = 20
            
            for index in 0...blockCount - 1 {
                let block = UIView()
                block.backgroundColor = .clearColor()
                block.translatesAutoresizingMaskIntoConstraints = false
                addSubview(block)
                
                let blockKey = "block" + String(index)
                views[blockKey] = block
                blockFormatString += "[" + blockKey + "]"
                
                constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[" + blockKey + "]|", options: [], metrics: nil, views: views)
                constraints.append(NSLayoutConstraint(item: block, attribute: .Width, relatedBy: .Equal, toItem: block.superview, attribute: .Width, multiplier: 1 / CGFloat(blockCount), constant: 0))
                
                let separator = UIView()
                block.addSubview(separator)
                separator.translatesAutoresizingMaskIntoConstraints = false
                separator.backgroundColor = .whiteColor()
                separator.alpha = 0.5
                let separatorKey = "separator" + String(index)
                views[separatorKey] = separator
                
                constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|->=0-[" + separatorKey + "(1@20)]|", options: [], metrics: nil, views: views)
                constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[" + separatorKey + "]|", options: [], metrics: nil, views: views)
            }
            
            blockFormatString += "|"
            
            constraints += NSLayoutConstraint.constraintsWithVisualFormat(blockFormatString, options: [], metrics: nil, views: views)
            
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-1-[progressView]-1-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-1-[progressView]-1-|", options: [], metrics: nil, views: views)
            
            NSLayoutConstraint.activateConstraints(constraints)
        }
        
        func configure(withViewModel viewModel: Model) {
            let width = (bounds.width * viewModel.share - 2) * 2 > 0 ? (bounds.width * viewModel.share - 2) * 2 : 0
            let height = progressView.bounds.height * 2
            
            gradientLayer.colors = viewModel.thresholdReached ? thresholdReachedColors : progressColors
            gradientLayer.bounds = CGRect(origin: CGPointZero, size: CGSize(width: width , height: height ))
        }
        
        // MARK: - Model
        struct Model {
            let share: CGFloat
            let thresholdReached: Bool
            
            init(value: Int, threshold: Int) {
                share = value > threshold ? 1 : 100 / CGFloat(threshold) * CGFloat(value) / 100
                thresholdReached = value > threshold
            }
        }
    }
}