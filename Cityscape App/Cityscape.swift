//
//  ViewController.swift
//  GuillotineMenu
//
//  Modified by Matthew Wall 2016

import UIKit

class CityscapeViewController: UIViewController {

    let reuseIdentifier = "ContentCell"
    fileprivate let cellHeight: CGFloat = 210
    fileprivate let cellSpacing: CGFloat = 20
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var currentRadius:CGFloat = 0.0
    
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
        navBar.barTintColor = UIColor(red: 69.0 / 255.0, green: 67.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self,
            action: Selector(("swipeMenu:")))
        screenEdgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEdgeRecognizer)

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
    
    @IBAction func showMenuAction(_ sender: UIButton) {
        let menuVC = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuVC.modalPresentationStyle = .custom
        menuVC.transitioningDelegate = self
        if menuVC is GuillotineAnimationDelegate {
            presentationAnimator.animationDelegate = menuVC as? GuillotineAnimationDelegate
        }
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        self.present(menuVC, animated: true, completion: nil)
    }
    
}

// The following is just for the presentation that'll be used later. You can ignore it
extension CityscapeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 //how many views we have in our collectionView
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnyObject? = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell as! UICollectionViewCell!
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - cellSpacing, height: cellHeight)
    }
}

extension CityscapeViewController: UIViewControllerTransitioningDelegate {
	
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
