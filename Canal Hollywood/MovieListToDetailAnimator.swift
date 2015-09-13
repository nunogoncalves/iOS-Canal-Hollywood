//
//  MovieListToDetailAnimator.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 13/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class TableCellAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ScheduleController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! MovieDetailsController
        
        //        //make a snapshot of the selected cell
        let cellView = fromVC.lastSelectedCell
        
        transitionContext.containerView().insertSubview(toVC.view, belowSubview: cellView!)

        let smallMovieImageView = fromVC
        
        transitionContext.containerView().addSubview(cellView!)

        let width = fromVC.view.bounds.size.width
        toVC.view.transform = CGAffineTransformMakeTranslation(width, 0.0)

        (UIApplication.sharedApplication().windows.first as! UIWindow).backgroundColor = UIColor.whiteColor()

        let duration = transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration / 4,
            animations: {
                fromVC.view.transform = CGAffineTransformMakeTranslation(-width, 0.0)
                cellView!.backgroundImage.alpha = 0.0
                cellView!.movieLocalNameLabel.alpha = 0.0
                cellView!.movieOriginalNameLabel.alpha = 0.0
                cellView!.startTimeLabel.alpha = 0.0
                cellView?.genreLabel.alpha = 0.0
            }, completion: { _ in
            }
        )
    
        UIView.animateWithDuration(duration/4,
            delay: duration/4,
            options: nil,
            animations: {
                cellView!.center.y = cellView!.bounds.size.height/2 + fromVC.topLayoutGuide.length
            }, completion: { _ in
        })
        
        UIView.animateWithDuration(duration/4,
            delay: 2 * duration/4,
            options: nil,
            animations: {
                cellView!.movieImageView.transform = CGAffineTransformMakeScale(2.0, 2.0)
            }, completion: { _ in
        })
        
        UIView.animateWithDuration(duration/4,
            delay: 2 * duration/4,
            options: nil,
            animations: {
//                toVC.view.transform = CGAffineTransformIdentity
            }, completion: { _ in
                fromVC.view.transform = CGAffineTransformIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
        
//        UIView.animateAndChainWithDuration(duration/4, delay: 0.0, options: nil, animations: {
//            //1st animation
//            fromVC.view.transform = CGAffineTransformMakeTranslation(-width, 0.0)
//            
//            }, completion:nil).animateWithDuration(duration/4, animations: {
//                //2nd animation
//                cellView.center.y = cellView.bounds.size.height/2 + fromVC.topLayoutGuide.length
//                
//            }).animateWithDuration(duration/4, animations: {
//                //3rd animation
//                toVC.view.transform = CGAffineTransformIdentity
//                
//            }).animateWithDuration(duration/4, animations: {
//                //4th animation
//                cellView.alpha = 0.0
//                
//                }, completion: {_ in
//                    //animation completed
//                    
//                    fromVC.view.transform = CGAffineTransformIdentity
//                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
//            })
        
    }
    
}