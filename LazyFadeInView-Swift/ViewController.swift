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
        
        self.lazyFadeInView = LazyFadeInView.init(frame: CGRectMake(20, 100, UIScreen.mainScreen().bounds.size.width - 40, 200))
        self.lazyFadeInView?.textColor = UIColor.blackColor()
        self.lazyFadeInView?.text = strayBirds
        self.view.addSubview(lazyFadeInView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textToggled(sender: AnyObject) {
        self.lazyFadeInView?.text = (sender as! UISwitch).on ? strayBirds : qianChiBiFu
    }
    var testView: UIView?
    var lazyFadeInView: LazyFadeInView!
    let strayBirds = "Stray birds of summer come to my window to sing and fly away. And yellow leaves of autumn, which have no songs, flutter and fall there with a sign. O Troupe of little vagrants of the world, leave your footprints in my words."
    let qianChiBiFu = "惟江上之清风，与山间之明月，耳得之而为声，目遇之而成色。取之无禁，用之不竭。是造物者之无尽藏也，而吾与子之所共适。"
}

