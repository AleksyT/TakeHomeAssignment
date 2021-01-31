//
//  EntryAnimationViewController.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 29/01/2021.
//

import UIKit
import Lottie

fileprivate struct LottieAnimationConsts {
    let name = "bandPlaying"
    let size = CGSize(width: 300, height: 300)
    let fromProgress: AnimationProgressTime = 0.0
    let toProgress: AnimationProgressTime = 0.5
    let centerYOffset: CGFloat = -50
}

class EntryAnimationViewController: UIViewController {
    
    private let hideStackViewDuration = 1.0
    private let lottieAnimationConsts = LottieAnimationConsts()
    
    var animationView: AnimationView?
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        hideStackViewAnimation()
        makeLottieAnimationView()
        showPlayingBandLottieAnimation()
    }
    
    private func hideStackViewAnimation() {
        UIView.transition(with: stackView, duration: hideStackViewDuration,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.stackView.isHidden = true
                      })
    }
    
    private func makeLottieAnimationView() {
        animationView = AnimationView(name: lottieAnimationConsts.name)
        animationView?.center = self.view.center
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .playOnce
        view.addSubview(animationView!)
        
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        
        animationView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: lottieAnimationConsts.centerYOffset).isActive = true
        animationView?.heightAnchor.constraint(equalToConstant: lottieAnimationConsts.size.height).isActive = true
        animationView?.widthAnchor.constraint(equalToConstant: lottieAnimationConsts.size.width).isActive = true
    }
    
    private func showPlayingBandLottieAnimation() {
        self.animationView?.play(fromProgress: lottieAnimationConsts.fromProgress, toProgress: lottieAnimationConsts.toProgress, loopMode: .playOnce, completion: {  _ in
            let mainScreen = AlbumsViewController()
            let navigationController = UINavigationController(rootViewController: mainScreen)
            navigationController.navigationBar.backgroundColor = UIColor.Theme.background
            navigationController.navigationBar.isHidden = true
            self.present(navigationController, animated: true)
        })
        Player.sharedInstance.playSound(name: lottieAnimationConsts.name)
    }
}

