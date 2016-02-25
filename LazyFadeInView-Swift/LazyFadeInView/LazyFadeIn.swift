//
//  LazyFadeIn.swift
//  LazyFadeInView-Swift
//
//  Created by You Tu on 16/2/1.
//  Copyright © 2016年 Tu You. All rights reserved.
//

import Foundation
import UIKit

@objc protocol LazyFadeIn {
    
    //! @abstract The number of layers lazy loading. Defaults to 6.
    optional var numberOfLayers: Int { get set }
    
    //! @abstract The interval of layers fading. Defaults to 0.03
    optional var interval: CFTimeInterval { get set }
    
    //! @abstract The font of text. Defaults to [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]
    optional var textFont: UIFont { get set }
    
    //! @abstract The color of text. Defaults to white color
    optional var textColor: UIColor { get set }
    
    //! @abstract Text. Defaults to nil
    optional var text: String { get set }
    
    //! @abstract The attributes of text. Defaults to nil.
    optional var attributes: Dictionary<String, AnyObject> { get set }
    
}