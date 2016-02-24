//
//  LazyFadeInView.swift
//  LazyFadeInView-Swift
//
//  Created by You Tu on 16/2/1.
//  Copyright © 2016年 Tu You. All rights reserved.
//

import UIKit

protocol LazyFadeInViewDelegate {
    
}

class LazyFadeInView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override class func layerClass() -> AnyClass {
        return LazyFadeInLayer.self
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clearColor()
        self.layer.contentsScale = UIScreen.mainScreen().scale
    }
}
