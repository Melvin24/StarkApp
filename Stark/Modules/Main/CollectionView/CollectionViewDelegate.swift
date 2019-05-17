//
//  CollectionViewDelegate.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

class CollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    /// Helpers
    let lineSpacing: CGFloat = 4
    let interItemSpacing: CGFloat = 4
    let numberOfItemsPerRowPortrait: CGFloat = 2
    let numberOfItemsPerRowLandscape: CGFloat = 3
    let sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    let sectionHeaderHeight: CGFloat = 30

    /// Current device, used to check for orientation.
    var device = UIDevice.current

    @IBOutlet weak var viewController: MainViewController!

    /// Asks the delegate for the spacing between successive items in the rows or columns of a section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    /// Asks the delegate for the spacing between successive rows or columns of a section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }

    /// Asks the delegate for the margins to apply to content in the specified section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        } else {
            return CGSize(width: viewController.view.frame.width, height: sectionHeaderHeight)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let jobs = viewController.presenter.jobs,
            let jobCollectionViewCell = cell as? JobCollectionViewCell else {
            return
        }

        let job: Jobs.Job

        switch indexPath.section {
        case 0:
            job = jobs.master

        case 1:
            job = jobs.pullRequests[indexPath.row]

        case 2:
            job = jobs.releases[indexPath.row]

        default:
            return

        }

        if job.status == .building {
            jobCollectionViewCell.animateStatusView()
        } else {
            jobCollectionViewCell.removeStatusViewAnimation()
        }

    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let jobCollectionViewCell = cell as? JobCollectionViewCell else {
                return
        }

        jobCollectionViewCell.removeStatusViewAnimation()
    }

}
