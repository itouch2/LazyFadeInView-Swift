//
//  LazyFadeInView.swift
//  LazyFadeInView-Swift
//
//  Created by You Tu on 16/2/1.
//  Copyright © 2016年 Tu You. All rights reserved.
//

import UIKit

protocol LazyFadeInViewDelegate: class {
    func fadeInAnimationDidEnd(fadeInView: LazyFadeInView);
}

class LazyFadeInView: UIView, LazyFadeIn {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    override class func layerClass() -> AnyClass {
        return LazyFadeInLayer.self
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clearColor()
        self.layer.contentsScale = UIScreen.mainScreen().scale
        (self.layer as! LazyFadeInLayer).soureView = self
    }
    
    func lazyFadeInLayerAnimationDidEnd() {
        self.delegate?.fadeInAnimationDidEnd(self)
    }
    
    var numberOfLayers: Int {
        get {
            return (self.layer as! LazyFadeInLayer).numberOfLayers
        }
        set {
            (self.layer as! LazyFadeInLayer).numberOfLayers = newValue
        }
    }
    
    var interval: CFTimeInterval {
        get {
            return (self.layer as! LazyFadeInLayer).interval
        }
        set {
            (self.layer as! LazyFadeInLayer).interval = newValue
        }
    }
    
    var textFont: UIFont {
        get {
            return (self.layer as! LazyFadeInLayer).textFont
        }
        set {
            (self.layer as! LazyFadeInLayer).textFont = newValue
        }
    }
    
    var textColor: UIColor {
        get {
            return (self.layer as! LazyFadeInLayer).textColor
        }
        set {
            (self.layer as! LazyFadeInLayer).textColor = newValue
        }
    }
    
    var text: String {
        get {
            return (self.layer as! LazyFadeInLayer).text
        }
        set {
            (self.layer as! LazyFadeInLayer).text = newValue
        }
    }
    
    var attributes: Dictionary<String, AnyObject> {
        get {
            return (self.layer as! LazyFadeInLayer).attributes
        }
        set {
            (self.layer as! LazyFadeInLayer).attributes = newValue
        }
    }
    
    weak var delegate: LazyFadeInViewDelegate?
}
