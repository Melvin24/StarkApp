//
//  MasterHeaderCollectionReusableView.swift
//  Stark
//
//  Created by Melvin John on 18/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

class MasterHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var pulsingView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusView: UIView!

    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.pulsingView.layer.masksToBounds = true
        self.statusView.backgroundColor = .white

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.setCircularStatusView()
    }

    func setCircularStatusView() {
        self.pulsingView.layer.cornerRadius = CGFloat(roundf(Float(self.pulsingView.frame.size.width / 2.0)))
    }

    func animatePulsingView() {

        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {

            self.pulsingView.alpha = 0

        }, completion: nil)

    }

    func removePulsingViewAnimation() {
        pulsingView.layer.removeAllAnimations()
        pulsingView.alpha = 1
    }
}
