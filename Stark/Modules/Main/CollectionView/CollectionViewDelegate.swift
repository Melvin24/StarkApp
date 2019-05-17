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
    let sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)

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

        let maxContentWidth = viewController.view.frame.width

        let availableContentWidth = maxContentWidth - (sectionInset.left + sectionInset.right + interItemSpacing)

        guard availableContentWidth > 0 else {
            return .zero
        }

        let itemsPerRow = device.orientation.isLandscape ? numberOfItemsPerRowLandscape : numberOfItemsPerRowPortrait

        let maxWidthAndHeightPerItem = availableContentWidth/itemsPerRow

        return CGSize(width: maxWidthAndHeightPerItem, height: maxWidthAndHeightPerItem)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}
