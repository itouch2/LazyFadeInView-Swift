//
//  LazyFadeInLayer.swift
//  LazyFadeInView-Swift
//
//  Created by You Tu on 16/2/1.
//  Copyright © 2016年 Tu You. All rights reserved.
//

import UIKit

class LazyFadeInLayer: CATextLayer, LazyFadeIn {

    override init() {
        super.init()
        self.wrapped = true
        self.fadeInNumberOfLayers = 6
        self.fadeInTextFont = UIFont(name: "HelveticaNeue-Light", size: 18)!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fadeInNumberOfLayers: Int!
    var numberOfLayers: Int {
        get {
            return self.fadeInNumberOfLayers
        }
        set {
            self.fadeInNumberOfLayers = newValue
        }
    }
    
    var fadeInInterval: CFTimeInterval = 0.03
    var interval: CFTimeInterval {
        get {
            return self.fadeInInterval
        }
        set {
            self.fadeInInterval = newValue
            self.updateAnimating()
        }
    }
    
    var fadeInTextFont: UIFont?
    var textFont: UIFont {
        get {
            return fadeInTextFont!
        }
        set {
            self.fadeInTextFont = newValue
            self.updateAnimating()
        }
    }
    
    var fadeInTextColor: UIColor?
    var textColor: UIColor {
        get {
            return fadeInTextColor!
        }
        set {
            self.fadeInTextColor = newValue
            self.updateAnimating()
        }
    }
    
    var fadeInText: String?
    var text: String {
        get {
            return self.fadeInText!
        }
        set {
            self.fadeInText = newValue
            
            self.animatingAttributedString = NSMutableAttributedString.init(string: self.fadeInText!)
            self.animatingAttributedString?.addAttribute(NSFontAttributeName, value: self.textFont, range: NSMakeRange(0, (self.fadeInText?.characters.count)!))
            self.updateAnimating()
        }
    }
    
    var fadeInAttributes: Dictionary<String, AnyObject>?
    var attributes: Dictionary<String, AnyObject> {
        get {
            return self.fadeInAttributes!
        }
        set {
            self.fadeInAttributes = newValue
            self.updateAnimating()
        }
    }
    
    weak var soureView: UIView?

    lazy var displayLink: CADisplayLink = CADisplayLink()
    lazy var alphaArray: Array<Double> = Array()
    lazy var tmpArray: Array<Int> = Array()
    
    var isAnimating: Bool = false
    var frameCount: Int = 0

    var attributedString: NSMutableAttributedString?
    var animatingAttributedString: NSMutableAttributedString?
    
    func updateAnimating() {
        if self.fadeInText?.characters.count > 0 {
            if self.isAnimating {
                self.stopAnimating()
            }
            self.startAnimating()
        } else {
            if self.isAnimating {
                self.stopAnimating()
            }
        }
    }
    
    func startAnimating() {
        if self.fadeInText?.characters.count == 0 {
            return
        }
        
        self.setupAlphaArray()
        
        self.frameCount = 0
        self.isAnimating = true
        self.displayLink = CADisplayLink(target: self, selector: Selector("updateUI"))
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func stopAnimating() {
        isAnimating = false
        self.string = self.animatingAttributedString
        self.displayLink.invalidate()
    }
    
    func updateUI() {
        self.frameCount++
        
        var isFinished: Bool = true
        
        var toAlpha: CGFloat = 0.0
        var toRed: CGFloat = 0.0
        var toGreen: CGFloat = 0.0
        var toBlue: CGFloat = 0.0
        
        if self.fadeInText == nil || self.fadeInTextColor == nil {
            return
        }
        
        self.fadeInTextColor?.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        for index in 1..<(self.fadeInText!.characters.count) {
            let currentAlpha: CGFloat = CGFloat(self.alphaArray[index]) + CGFloat(self.frameCount) * CGFloat(self.interval)
            if isFinished && currentAlpha < toAlpha {
                isFinished = false
            }
            let currentColor: UIColor = UIColor.init(red: toRed, green: toGreen, blue: toBlue, alpha: currentAlpha)
            self.animatingAttributedString?.addAttribute(NSForegroundColorAttributeName, value: currentColor, range: NSMakeRange(index, 1))
        }
        
        if isFinished {
            self.stopAnimating()
            return
        }
        
        self.string = self.animatingAttributedString
    }
    
    func randomAlphaArray() {
        if self.fadeInText!.characters.count != 0 && self.fadeInNumberOfLayers <= 0 {
            return
        }
        
        let totalCount: Int = self.fadeInText!.characters.count
        var tTotalCount: Int = totalCount + 1
        
        self.tmpArray = Array()
        
        for _ in 0..<self.numberOfLayers - 1 {
            let k: Int = Int(arc4random_uniform(UInt32(tTotalCount)))
            self.tmpArray.append(k)
            tTotalCount = tTotalCount - k
        }
        
        self.tmpArray.append(tTotalCount - 1)
        
        for (index, value) in self.tmpArray.enumerate() {
            let alpha: CGFloat = -CGFloat(index) * 0.25
            var count = value
            while count > 0 {
                let k: Int = Int(arc4random_uniform(UInt32(totalCount)))
                if self.alphaArray[k] > 0.01 {
                    self.alphaArray[k] = Double(alpha)
                    count--
                }
            }
        }
    }
    
    func setupAlphaArray() {
        if self.alphaArray.count > 0 {
            if self.text.characters.count != self.alphaArray.count {
                self.resetAlphaArray()
            }
        } else {
            self.resetAlphaArray()
        }
    }
    
    func resetAlphaArray() {
        self.alphaArray.removeAll()
        
        if self.fadeInText != nil {
            self.alphaArray = Array(count: self.fadeInText!.characters.count, repeatedValue: Double(MAXFLOAT))
            self.randomAlphaArray()
        }
    }
}
