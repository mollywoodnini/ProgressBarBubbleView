//
//  NSNumberFormatter+PercentFormatter.swift
//  ProgressBarBubbleView
//
//  Created by Tan Nghia La on 12.05.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import Foundation

extension NSNumberFormatter {
    private struct SharedPercentFormatter {
        
        static let instance: NSNumberFormatter = {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .PercentStyle
            formatter.multiplier = 1
            return formatter
        }()
    }
    
    class func formatAsString(number: NSNumber) -> String {
        return SharedPercentFormatter.instance.stringFromNumber(number.floatValue)!
    }
}