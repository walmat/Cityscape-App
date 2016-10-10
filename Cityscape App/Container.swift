//
//  Container.swift
//  GuillotineMenuExample
//
//  Created by Matthew Wall on 4/7/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class Container: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChildView(){
        let vc = UIViewController()
        
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)
    }
    
    func removeChildView(_ vc: UIViewController){
        vc.willMove(toParentViewController: nil)
        
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }


}
