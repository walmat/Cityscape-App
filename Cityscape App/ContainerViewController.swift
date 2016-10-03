//
//  ContainerViewController.swift
//  GuillotineMenuExample
//
//  Created by Matthew Wall on 4/14/16.
//  Copyright © 2016. All Rights Reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var currentVC: UIViewController!
    var currentVCIdentifier: String = ""
    
    @IBOutlet var barButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("VC: viewDidDisappear")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor(red: 134.0 / 255.0, green: 102.0 / 255.0, blue: 186.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self,
            action: Selector(("swipeMenu:")))
        screenEdgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        self.addChildView("Cityscape")
        
    }
    
    @IBAction func handlePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        //create point for when the user lets go for the screen to swing back/forward
        //turningPoint = CGPointMake(self.view.frame.width / 2, self.view.frame.height / 2)
        
        if sender.state == .ended {
            //start dynamic guillotine animation
            
        }
        else {
            //determine whether to replace view or swing back
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenuSegue" {
            let menu = segue.destination as! MenuViewController
            menu.delegate = self
        }
    }
    
    @IBAction func showMenuAction(_ sender: UIButton) {
        let menuVC = storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.modalPresentationStyle = .custom
        menuVC.transitioningDelegate = self
        menuVC.delegate = self
        menuVC.titleLabelText = self.navigationItem.title!
        presentationAnimator.animationDelegate = menuVC
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        self.present(menuVC, animated: true, completion: nil)
    }
    
    
    func addChildView(_ identifier: String){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            return
        }
        
        self.addChildViewController(vc)
        vc.view.frame = self.view.bounds
        self.view.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)
        
        currentVC = vc
        currentVCIdentifier = identifier
        
    }
    
    func removeChildView(_ vc: UIViewController){
        vc.willMove(toParentViewController: nil)
        
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    func swapCurrentView(_ identifier: String) {
        
        guard currentVCIdentifier != identifier else { return }
        removeChildView(currentVC)
        addChildView(identifier)
    }
    
}

extension String {
    var length: Int {
        return characters.count
    }
}

extension ContainerViewController: menuViewControllerDelegate {
    
    func menuViewController(_ menuVC: MenuViewController, willCloseMenuWithType type: viewName) {
        self.swapCurrentView(type.stringName)
        self.navigationItem.title = "Cityscape"
    }
}


extension ContainerViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
