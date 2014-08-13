//
//  ViewController.swift
//  SampleApplication
//
//  Created by dtissera on 13/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var indicator1: DTIActivityIndicatorView!
    @IBOutlet weak var indicator2: DTIActivityIndicatorView!
    @IBOutlet weak var indicator3: DTIActivityIndicatorView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicator1.startActivity()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.indicator2.startActivity()
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.indicator3.startActivity()
        })
        
        let indicator4 = DTIActivityIndicatorView(frame: CGRect(x:0.0, y:0.0, width:40.0, height:40.0));
        self.view.addSubview(indicator4)
        indicator4.center = self.view.center
        indicator4.indicatorColor = UIColor.whiteColor()
        indicator4.startActivity()
    }

}

