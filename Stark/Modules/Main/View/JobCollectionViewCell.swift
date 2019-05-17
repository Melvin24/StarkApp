//
//  JobCollectionViewCell.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

class JobCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var jobNameLabel: UILabel!

    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.statusView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.setCircularStatusView()
    }

    func setCircularStatusView() {
        self.statusView.layer.cornerRadius = CGFloat(roundf(Float(self.statusView.frame.size.width / 2.0)))
    }

    func animateStatusView() {

        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {

            self.statusView.alpha = 0

        }, completion: nil)

    }

    func removeStatusViewAnimation() {
        statusView.layer.removeAllAnimations()
        statusView.alpha = 1
    }

}
