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
    let interItemSpacing: CGFloat = 0
    let sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    let defaultSectionHeaderHeight: CGFloat = 30
    let masterSectionHeight: CGFloat = 90
    let cellHeight: CGFloat = 80

    /// Current device, used to check for orientation.
    var device = UIDevice.current

    @IBOutlet weak var viewController: MainViewController!

    /// Asks the delegate for the spacing between successive items in the rows or columns of a section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }

    /// Asks the delegate for the spacing between successive rows or columns of a section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }

    /// Asks the delegate for the margins to apply to content in the specified section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: viewController.view.frame.width, height: masterSectionHeight)
        } else {
            return CGSize(width: viewController.view.frame.width, height: defaultSectionHeaderHeight)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let jobs = viewController.presenter.jobs,
            let masterCell = cell as? JobCollectionViewCell else {
            return
        }

        let job: JobsViewModel.JobViewModel

        switch indexPath.section {

        case 1:
            job = jobs.pullRequests[indexPath.row]

        case 2:
            job = jobs.releases[indexPath.row]

        default:
            return

        }

        if job.shouldAnimateStatus {
            masterCell.animatePulsingView()
        } else {
            masterCell.removePulsingViewAnimation()
        }

    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let masterCell = cell as? JobCollectionViewCell else {
                return
        }

        masterCell.removePulsingViewAnimation()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {

        guard let jobs = viewController.presenter.jobs,
            let view = view as? MasterHeaderCollectionReusableView else {
                return
        }

        if jobs.master.shouldAnimateStatus {
            view.animatePulsingView()
        } else {
            view.removePulsingViewAnimation()
        }

    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {

        guard let view = view as? MasterHeaderCollectionReusableView else {
                return
        }

        view.removePulsingViewAnimation()

    }

}
