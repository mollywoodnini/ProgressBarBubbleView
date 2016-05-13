//
//  UILabelWithInset.swift
//  ProgressBarBubbleView
//
//  Created by Tan Nghia La on 12.05.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import Foundation
import UIKit

final class UILabelWithInset:UILabel
{
    private let customEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    init() {
        super.init(frame: .zero)
    }
    
    override func intrinsicContentSize() -> CGSize {
        let intrinsicContentSize = super.intrinsicContentSize()
        return CGSizeMake(intrinsicContentSize.width + customEdgeInset.left + customEdgeInset.right, intrinsicContentSize.height + customEdgeInset.top + customEdgeInset.bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        self.drawTextInRect(UIEdgeInsetsInsetRect(rect, customEdgeInset))
    }
}