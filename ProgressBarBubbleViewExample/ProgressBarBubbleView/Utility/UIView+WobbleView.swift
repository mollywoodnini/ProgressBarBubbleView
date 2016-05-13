//
//  UIView+WobbleView.swift
//  ProgressBarBubbleView
//
//  Created by Tan Nghia La on 13.05.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func wobbleView(duration:NSTimeInterval, maxSize:Float, delay:NSTimeInterval, completion: ((Bool) -> Void)?=nil) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            let sx: CGFloat = 1.0 + CGFloat(maxSize)
            let sy: CGFloat = 1.0 + CGFloat(maxSize)
            let sz: CGFloat = 1.0
            self.layer.transform = CATransform3DMakeScale(sx, sy, sz)
            }, completion: { finished in
                UIView.animateWithDuration(duration, animations: { [weak self] () -> Void in
                    self?.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
                    }, completion: { (finished) in
                        completion?(true)
            })
        })
    }
}