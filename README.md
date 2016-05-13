# ProgressBarBubbleView

The ProgressBarBubbleView is a UIView subclass, which displays the progress in a bar and in percent within a bubble view. Completely written in Swift.

## Screenshots
![Preview](https://cloud.githubusercontent.com/assets/5786065/15242917/fe98ab64-18f8-11e6-84cd-57f4ec0d906c.gif
)

## Installation

### Manually

1. Download **ProgressBarBubbleView.zip** from the [last release](https://github.com/mollywoodnini/ProgressBarBubbleView/releases/latest) and extract its content.
2. Copy the **ProgressBarBubbleView** folder into your Xcode Project.

## Usage

### Initializing
If you are using Autolayout:
```swift
private let progressBarBubbleView = ProgressBarBubbleView(bubbleHeight: 40, barHeight: 10)
```

If you layout your UI via frames:
```swift
private let progressBarBubbleView = ProgressBarBubbleView(bubbleHeight: 40, barHeight: 10, width: 300, position: CGPointZero)
```

### Updating your process
```swift
let value: Int = 400
let threshold: Int = 600
progressBarBubbleView.configure(value, threshold: threshold)
```

### Customizable properties
* textColor
* font
* bubbleBackgroundColor
* progressColors // gradient colors
* thresholdReachedColors // gradient colors

## Requirements
- iOS 8.0+
- Xcode 7.0+

## License

Released under the MIT license. See the LICENSE file for more info.
