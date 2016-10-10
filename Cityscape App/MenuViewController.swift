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
    public var logoView: UIImageView?
    

    //GuillotineMenu protocol

    var titleLabelText: String = "this is a long string"
    weak var delegate: menuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton = UIButton(frame: CGRect.zero)
        dismissButton?.setImage(UIImage(named: "ic_menu"), for: UIControlState())
        dismissButton?.addTarget(self, action: #selector(MenuViewController.dismissButtonTapped(_:)), for: .touchUpInside)
        
        //update logoview constraints to be uniform across all orientations
        logoView = UIImageView()
        logoView?.translatesAutoresizingMaskIntoConstraints = false
        
        logoView?.image = UIImage(named: "logo");
        logoView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MenuViewController.logoTapped(_:))));
        logoView?.isUserInteractionEnabled = true;
        
        self.view.addSubview(logoView!);
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            let widthConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
            
            let heightConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
            
            let xConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 50)
            
            let yConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
            logoView?.contentMode = .scaleAspectFit
            NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
            
        }
        else {
            let widthConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
        
            let heightConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
        
            let xConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        
            let yConstraint = NSLayoutConstraint(item: logoView! as UIView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 40)
            logoView?.contentMode = .scaleAspectFit
            NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
        }
        
    
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
    
    @IBAction func logoTapped(_ sender: UIImageView) {
        if delegate != nil {
            delegate?.menuViewController(self, willCloseMenuWithType: viewName(rawValue: 0)!)
        }
        self.titleLabel?.text = "Cityscape"
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        if delegate != nil {
            delegate?.menuViewController(self, willCloseMenuWithType: viewName(rawValue: sender.tag)!)
        }
        print("Button Clicked \(sender.tag)")
        self.titleLabel?.text = "Cityscape"
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
