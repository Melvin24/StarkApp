//
//  StatusViewPresenter.swift
//  FruitViewer

import UIKit

protocol StatusViewPresenter: class {
    
    /// Status view.
    var statusView: UIView? { get set }
    
    /// Container view to add status view.
    var statusContainerView: UIView! { get set }
    
}

extension StatusViewPresenter {
    
    /// Responsible for changing status view. Pass nill to remove current status view.
    ///
    /// - Parameter newStatusView: new status view for example an Error View.
    func changeStatusView(with newStatusView: UIView?) {
        
        self.statusView?.removeFromSuperview()
        
        self.statusView = newStatusView
        
        guard let statusView = self.statusView, let containerView = self.statusContainerView else {
            return
        }
        
        containerView.addSubview(statusView)
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewBindings: [String : Any] = [ "statusView": statusView ]
        
        containerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[statusView]|",
                                           options: NSLayoutConstraint.FormatOptions(),
                                           metrics: nil,
                                           views: viewBindings)
        )
        
        containerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[statusView]|",
                                           options: NSLayoutConstraint.FormatOptions(),
                                           metrics: nil,
                                           views: viewBindings)
        )
        
        containerView.bringSubviewToFront(statusView)
        
    }
    
}
