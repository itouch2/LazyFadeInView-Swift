//
//  ViewController.swift
//  LazyFadeInView-Swift
//
//  Created by You Tu on 16/2/1.
//  Copyright © 2016年 Tu You. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let lazyFadeInView: LazyFadeInView? = LazyFadeInView.init(frame: CGRectMake(20, 100, UIScreen.mainScreen().bounds.size.width - 40, 200))
        lazyFadeInView?.textColor = UIColor.blackColor()
        lazyFadeInView?.text = "Stray birds of summer come to my window to sing and fly away. And yellow leaves of autumn, which have no songs, flutter and fall there with a sign. O Troupe of little vagrants of the world, leave your footprints in my words.";
        self.view.addSubview(lazyFadeInView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

