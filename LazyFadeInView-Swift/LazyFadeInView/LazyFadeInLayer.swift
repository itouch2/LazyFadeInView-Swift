//
//  LazyFadeInLayer.swift
//  LazyFadeInView-Swift
//
//  Created by You Tu on 16/2/1.
//  Copyright © 2016年 Tu You. All rights reserved.
//

import UIKit

class LazyFadeInLayer: CATextLayer {
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var soureView: UIView?
    
    lazy var displayLink: CADisplayLink = CADisplayLink()
    lazy var alphaArray: Array<Double> = Array()
    lazy var tmpArray: Array<Int> = Array()
    
    var isAnimating: Bool?
    var frameCount: Int?
    var text: String?
    var textColor: UIColor?
    var numberOfLayers: Int?
    var attributedString: NSMutableAttributedString?
    var animatingAttributedString: NSMutableAttributedString?
    var interval: CFTimeInterval?
    
    func startAnimating() {
        if self.text?.characters.count == 0 {
            return
        }
        
        self.setupAlphaArray()
        
        self.isAnimating = true
        self.displayLink = CADisplayLink(target: self, selector: Selector("updateUI"))
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func stopAnimating() {
        isAnimating = false
        self.string = self.attributedString
        self.displayLink.invalidate()
    }
    
    func updateUI() {
        self.frameCount?++
        
        var isFinished: Bool = true
        
        var toAlpha: CGFloat = 0.0
        var toRed: CGFloat = 0.0
        var toGreen: CGFloat = 0.0
        var toBlue: CGFloat = 0.0
        
        self.textColor?.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        for index in 1..<(self.text!.characters.count) {
            let currentAlpha: CGFloat = CGFloat(self.alphaArray[index]) + CGFloat(self.frameCount!) * CGFloat(self.interval!)
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
        if self.text?.characters.count != 0 && self.numberOfLayers <= 0 {
            return
        }
        
        let totalCount = self.text?.characters.count
        let tTotalCount: UInt32 = UInt32(totalCount! + 1)
        
        self.tmpArray = Array()
        
        for _ in 0..<self.numberOfLayers! - 1 {
            let k: Int = Int(arc4random_uniform(UInt32(tTotalCount)))
            self.tmpArray.append(k)
        }
        
        self.tmpArray.append(totalCount! - 1)
        
        for (index, value) in self.tmpArray.enumerate() {
            let alpha: CGFloat = -CGFloat(index) * 0.25
            var count: Int = value
            while count > 0 {
                let k: Int = Int(arc4random_uniform(UInt32(tTotalCount))) % totalCount!
                if self.alphaArray[k] > 0.01 {
                    self.alphaArray[k] = Double(alpha)
                    count--
                }
            }
            
        }
    }
    
    func setupAlphaArray() {
        if self.alphaArray.count > 0 {
            if self.text!.characters.count != self.alphaArray.count {
                self.resetAlphaArray()
            }
        } else {
            self.resetAlphaArray()
        }
    }
    
    func resetAlphaArray() {
        self.alphaArray.removeAll()
        self.alphaArray = Array(count: (self.text?.characters.count)!, repeatedValue: Double(MAXFLOAT))
        
        self.randomAlphaArray()
    }
    
}
