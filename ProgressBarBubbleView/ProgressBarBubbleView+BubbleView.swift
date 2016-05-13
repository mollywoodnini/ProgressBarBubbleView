//
//  ProgressBarBubbleView+BubbleView.swift
//  ProgressBarBubbleView
//
//  Created by Tan Nghia La on 12.05.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import Foundation
import UIKit

extension ProgressBarBubbleView {
    final class BubbleView: UIView {
        // MARK: - Properties
        private let label = UILabelWithInset()
        private let shapeLayer = CAShapeLayer()
        private var isFadingOut = false
        private var labelLeadingXConstraint: NSLayoutConstraint?
        
        private var arrowPath: UIBezierPath {
            let fillPath = UIBezierPath()
            
            fillPath.moveToPoint(CGPoint(x: 0, y: bounds.height - Arrow.Height.value))
            fillPath.addLineToPoint(CGPoint(x: Arrow.LeftMargin.value, y: bounds.height - Arrow.Height.value))
            fillPath.addLineToPoint(CGPoint(x: Arrow.LeftMargin.value + Arrow.Width.value / 2, y: bounds.height))
            fillPath.addLineToPoint(CGPoint(x: Arrow.LeftMargin.value + Arrow.Width.value, y: bounds.height - Arrow.Height.value))
            fillPath.addLineToPoint(CGPoint(x: bounds.size.width, y: bounds.height - Arrow.Height.value))
            fillPath.addLineToPoint(CGPoint(x: bounds.size.width, y: bounds.height - Arrow.Height.value))
            fillPath.addLineToPoint(CGPoint(x: 0, y: bounds.height - Arrow.Height.value))
            fillPath.closePath()
            
            return fillPath
        }
        
        enum Arrow {
            case Height
            case Width
            case LeftMargin
            
            var value: CGFloat {
                switch self {
                case .Height:
                    return 10
                case .Width:
                    return 20
                case .LeftMargin:
                    return -10
                }
            }
        }
        
        var textColor: UIColor {
            get {
                return label.textColor
            }
            set {
                label.textColor = newValue
            }
        }
        
        var font: UIFont {
            get {
                return label.font
            }
            set {
                label.font = newValue
            }
        }
        
        var bubbleBackgroundColor: UIColor? {
            get {
                return label.backgroundColor
            }
            set {
                label.backgroundColor = newValue
                shapeLayer.fillColor = newValue?.CGColor
            }
        }

        
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
            
            shapeLayer.path = arrowPath.CGPath
            layer.addSublayer(shapeLayer)
        }
        
        // MARK: - View configuration
        private func configureView() {
            backgroundColor = .clearColor()
            
            shapeLayer.fillColor = UIColor.blueColor().CGColor
            shapeLayer.opacity = 0
            label.textAlignment = .Center
            label.textColor = .whiteColor()
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
            label.alpha = 0
            
            addSubview(label)
        }
        
        private func configureConstraints() {
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let views: [String: UIView] = [
                "label": label
            ]
            
            var constraints: [NSLayoutConstraint] = []            
            
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]-10-|", options: [], metrics: nil, views: views)
            labelLeadingXConstraint = NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: label.superview, attribute: .Leading, multiplier: 1.0, constant: 0.0)
            constraints.append(labelLeadingXConstraint!)
            
            NSLayoutConstraint.activateConstraints(constraints)
        }
        
        func configure(withViewModel viewModel: Model) {
            if bounds == CGRectZero {
                return
            }
            
            label.text = viewModel.text
            let x = bounds.width * viewModel.share
            
            moveLayer(CGPoint(x: x, y: 0))

            labelLeadingXConstraint?.constant = x - label.intrinsicContentSize().width / 2
            
            if viewModel.share == 1 && label.alpha == 1 && !isFadingOut {
                slowFadeOut()
            } else if viewModel.share < 1 {
                fadeInOut(viewModel.share)
            }
        }
        
        private func moveLayer(point: CGPoint) {
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = shapeLayer.valueForKey("position")
            animation.toValue = NSValue(CGPoint: point)
            animation.duration = 0.15
            shapeLayer.position = point
            shapeLayer.addAnimation(animation, forKey: "position")
        }
        
        private func slowFadeOut() {
            isFadingOut = true
            label.wobbleView(0.2, maxSize: 0.3, delay: 0, completion: { [weak self] (finished) in
                let duration: CFTimeInterval = 1
                self?.shapeLayer.opacity = 0
                
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.fromValue = 1
                animation.toValue = 0
                animation.duration = duration
                self?.shapeLayer.addAnimation(animation, forKey: "opacity")
                UIView.animateWithDuration(duration) { [weak self] () -> Void in
                    self?.label.alpha = 0
                    self?.isFadingOut = false
                    self?.layoutIfNeeded()
                }
            })
        }
        
        private func fadeInOut(share: CGFloat) {
            shapeLayer.opacity = share > 0 ? 1 : 0
            UIView.animateWithDuration(0.15) { [weak self] () -> Void in
                self?.label.alpha = share > 0 ? 1 : 0
                self?.layoutIfNeeded()
            }
        }
        
        // MARK: - Model
        struct Model {
            let text: String
            let share: CGFloat
            
            init(value: Int, threshold: Int) {
                share = value > threshold ? 1 : 100 / CGFloat(threshold) * CGFloat(value) / 100
                text = value > threshold ? NSNumberFormatter.formatAsString(100) : NSNumberFormatter.formatAsString(100 / CGFloat(threshold) * CGFloat(value))
            }
        }
    }
}