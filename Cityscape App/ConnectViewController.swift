//
//  ConnectViewController.swift
//  GuillotineMenuExample
//
//  Created by Matthew Wall on 4/8/16.
//  Copyright © 2016. All rights reserved.
//
    
import UIKit

class ConnectViewController: UIViewController {
    
    let reuseIdentifier = "ContentCell"
    private let cellHeight: CGFloat = 210
    private let cellSpacing: CGFloat = 20
    private lazy var presentationAnimator = GuillotineTransitionAnimation()
    
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
        navBar.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    @IBAction func showMenuAction(sender: UIButton) {
        let menuVC = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuVC.modalPresentationStyle = .custom
        menuVC.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        if menuVC is GuillotineAnimationDelegate {
            presentationAnimator.animationDelegate = menuVC as? GuillotineAnimationDelegate
        }
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        self.present(menuVC, animated: true, completion: nil)
    }
}
