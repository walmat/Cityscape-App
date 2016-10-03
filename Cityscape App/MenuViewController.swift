//
//  MenuViewController.swift
//  GuillotineMenuExample
//
//  Modified by Matthew Wall 2016

import Foundation
import UIKit

enum viewName: Int {
    case home = 0, purpose, connect, resources, settings
    var stringName: String {
        get { return self == .home ? "Cityscape" :
                     self == .purpose ? "Purpose" :
                     self == .connect ? "Connect" :
                     self == .resources ? "Resources" :
                                          "Settings"
        }
    }
}

protocol menuViewControllerDelegate: class {
    func menuViewController(_ menuVC: MenuViewController, willCloseMenuWithType type: viewName)
}

class MenuViewController: UIViewController, GuillotineMenu {
    public var titleLabel: UILabel?

    public var dismissButton: UIButton?

    //GuillotineMenu protocol
//    var dismissButton: UIButton?
//    var titleLabel: UILabel?
    var titleLabelText: String = "this is a long string"
    weak var delegate: menuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton = UIButton(frame: CGRect.zero)
        dismissButton?.setImage(UIImage(named: "ic_menu"), for: UIControlState())
        dismissButton?.addTarget(self, action: #selector(MenuViewController.dismissButtonTapped(_:)), for: .touchUpInside)
        
        titleLabel = UILabel()
        titleLabel?.numberOfLines = 1;
        titleLabel?.text = titleLabelText
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel?.textColor = UIColor.white
        titleLabel?.sizeToFit()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Menu: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Menu: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Menu: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Menu: viewDidDisappear")
    }
    
    func dismissButtonTapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        if delegate != nil {
            delegate?.menuViewController(self, willCloseMenuWithType: viewName(rawValue: sender.tag)!)
        }
        print("Button Clicked \(sender.tag)")
        self.titleLabel?.text = "Cityscape"//viewName(rawValue: sender.tag)?.stringName
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func closeMenu(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

extension MenuViewController: GuillotineAnimationDelegate {
    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishPresentation")
    }
    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishDismissal")
    }
    
    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation) {
        print("willStartPresentation")
    }
    
    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation) {
        print("willStartDismissal")
    }
}
