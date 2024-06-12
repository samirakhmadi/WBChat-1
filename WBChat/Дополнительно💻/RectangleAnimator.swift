//
//  RectangleAnimator.swift
//  WBChat
//
//  Created by Александр on 12.06.2024.
//

import Foundation
import UIKit

final class RectangleAnimator: NSObject {
    
    enum TransitionMode {
        case present, dismiss
    }
    
    private let transitionMode: TransitionMode
    private let duration: CGFloat
    
    init(
        duration: CGFloat,
        transitionMode: TransitionMode
    ) {
        self.duration = duration
        self.transitionMode = transitionMode
    }
}

extension RectangleAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        self.duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        switch transitionMode {
        case .present:
            guard let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                transitionContext.completeTransition(false)
                return
            }
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001).rotated(by: .pi)
            presentedView.alpha = 0.0
            presentedView.center = CGPoint(x: containerView.center.x, y: containerView.center.y - 50)
            containerView.addSubview(presentedView)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: []) {
                presentedView.transform = CGAffineTransform.identity
                presentedView.alpha = 1.0
                presentedView.center = containerView.center
            } completion: { finished in
                transitionContext.completeTransition(finished)
            }
            
        case .dismiss:
            guard let dismissedView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                transitionContext.completeTransition(false)
                return
            }
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: []) {
                dismissedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001).rotated(by: -.pi)
                dismissedView.alpha = 0.0
                dismissedView.center = CGPoint(x: containerView.center.x, y: containerView.center.y + 50)
            } completion: { finished in
                dismissedView.removeFromSuperview()
                transitionContext.completeTransition(finished)
            }
        }
    }
}
