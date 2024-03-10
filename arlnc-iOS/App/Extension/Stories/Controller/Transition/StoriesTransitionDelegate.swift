//
//  StoriesTransitionDelegate.swift
//  arlnc-iOS
//

import UIKit

protocol StoriesTransitionDelegate: AnyObject {
    
    func animationControllerForTransition(from: UIViewController, to: UIViewController) -> UIViewControllerAnimatedTransitioning?
    
    func selectCandTransition(_ selected: UIViewController) -> Void
}
