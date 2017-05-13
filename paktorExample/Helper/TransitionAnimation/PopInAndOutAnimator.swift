//
//  PopInAndOutAnimator.swift
//  PopInAndOutCollectionViewTransition
//
//  Created by Stefano Vettor on 15/12/15.
//  Copyright © 2015 Stefano Vettor. All rights reserved.
//

import Foundation
import UIKit

class transitionAnimationParameter {
    let nextView : UIView
    var nextAlpha : CGFloat = 0.0
    
    let originalView : UIView
    let originalPosition :CGPoint
    let originalTranformFrame : CGRect
    
    init(originalView:UIView, originalPosition : CGPoint ,nextView:UIView , nextAlpha:CGFloat ,originalTranformFrame : CGRect) {
        self.originalView = originalView
        self.nextView = nextView
        self.nextAlpha = nextAlpha
        self.originalPosition = originalPosition
        self.originalTranformFrame = originalTranformFrame
    }
}


class PopInAndOutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    fileprivate let _operationType : UINavigationControllerOperation
    fileprivate let _transitionDuration : TimeInterval
    
    
    init(operation: UINavigationControllerOperation) {
        _operationType = operation
        _transitionDuration = 0.4
    }
    
    init(operation: UINavigationControllerOperation, andDuration duration: TimeInterval) {
        _operationType = operation
        _transitionDuration = duration
    }
    
    //MARK: Push and Pop animations performers
//    internal func performPushTransition(transitionSytle:UINavigationControllerOperation, transitionContext: UIViewControllerContextTransitioning) {
//        
//        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
//                // Something really bad happend and it is not possible to perform the transition
//                print("ERROR: Transition impossible to perform since either the destination view or the conteiner view are missing!")
//                return
//        }
//        
//        let container = transitionContext.containerView
//        
//        
//        
//        switch transitionSytle {
//        case .push:
//            guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CollectionPushAndPoppable,
//                let fromView = fromViewController.collectionView,
//                let currentCell = fromViewController.sourceCell else {
//                    // There are not enough info to perform the animation but it is still possible
//                    // to perform the transition presenting the destination view
//                    container.addSubview(toView)
//                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                    return
//            }
//        case .pop:
//            guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CollectionPushAndPoppable,
//                let toCollectionView = toViewController.collectionView,
//                let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
//                let fromView = fromViewController.view,
//                let currentCell = toViewController.sourceCell else {
//                    // There are not enough info to perform the animation but it is still possible
//                    // to perform the transition presenting the destination view
//                    container.addSubview(toView)
//                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                    return
//            }
//
//        default:break
//        }
//        
//        
//        // Add to container the destination view
//        container.addSubview(toView)
//        
//        // Prepare the screenshot of the destination view for animation
//        let screenshotToView =  UIImageView(image: toView.screenshot)
//        // set the frame of the screenshot equals to the cell's one
//        screenshotToView.frame = currentCell.frame
//        // Now I get the coordinates of screenshotToView inside the container
//        let containerCoord = fromView.convert(screenshotToView.frame.origin, to: container)
//        // set a new origin for the screenshotToView to overlap it to the cell
//        screenshotToView.frame.origin = containerCoord
//        
//        // Prepare the screenshot of the source view for animation
//        let screenshotFromView = UIImageView(image: currentCell.screenshot)
//        screenshotFromView.frame = screenshotToView.frame
//        
//        // Add screenshots to transition container to set-up the animation
//        container.addSubview(screenshotToView)
//        container.addSubview(screenshotFromView)
//        
//        // Set views initial states
//        toView.isHidden = true
//        screenshotToView.isHidden = true
//        
//        
//        switch transitionSytle {
//        case .push:
//            // Delay to guarantee smooth effects
//            let delayTime = DispatchTime.now() + Double(Int64(0.08 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//            DispatchQueue.main.asyncAfter(deadline: delayTime) {
//                screenshotToView.isHidden = false
//            }
//            
//            UIView.animate(withDuration: _transitionDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
//                
//                screenshotFromView.alpha = 0.0
//                screenshotToView.frame = UIScreen.main.bounds
//                screenshotToView.frame.origin = CGPoint(x: 0.0, y: 0.0)
//                screenshotFromView.frame = screenshotToView.frame
//                
//            }) { _ in
//                
//                screenshotToView.removeFromSuperview()
//                screenshotFromView.removeFromSuperview()
//                toView.isHidden = false
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                
//            }
////        case .pop:
////            let containerCoord = toCollectionView.convert(currentCell.frame.origin, to: container)
////            
////            
////            transitionAnimation(transitionParameter: transitionAnimationParameter(originalView: screenshotFromView, originalPosition: containerCoord, nextView: screenshotToView, nextAlpha: 1.0 ,originalTranformFrame:self.currentCell.frame), transitionContext: transitionContext)
//            
//           
//        default:break
//        }
//        
//    }
    private func transitionAnimation(transitionParameter:transitionAnimationParameter ,transitionContext: UIViewControllerContextTransitioning){
        UIView.animate(withDuration: _transitionDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            
            transitionParameter.nextView.alpha = transitionParameter.nextAlpha
            transitionParameter.originalView.frame = transitionParameter.originalTranformFrame
            transitionParameter.originalView.frame.origin = transitionParameter.originalPosition
            transitionParameter.nextView.frame = transitionParameter.originalView.frame
            
        }) { _ in
            
//            self.currentCell.isHidden = false
            transitionParameter.originalView.removeFromSuperview()
            transitionParameter.nextView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        }
    }
    
    
    //MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return _transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        performPushTransition(transitionSytle: _operationType, transitionContext: transitionContext)
    }
}
