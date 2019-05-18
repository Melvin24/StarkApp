//
//  MainViewController.swift
//  Stark
//
//  Created by Melvin John on 14/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PresenterInteractor, StatusViewPresenter {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var statusContainerView: UIView!
    weak var statusView: UIView?

    /// Associated presenter.
    var presenter: MainPresenter!

    /// The control which manages the pull to refresh functionality.
    lazy var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = Colors.collectionViewBackground
        setupRefreshController(forCollectionView: collectionView)

        collectionView.register(nib: JobCollectionViewCell.self)
        collectionView.register(nib: JobHeaderCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(nib: MasterHeaderCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)

        presenter.loadIfRequired()

        self.title = "Builds"

    }

    private func setupRefreshController(forCollectionView collectionView: UICollectionView) {

        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)

        collectionView.alwaysBounceVertical = true

        collectionView.refreshControl = refreshControl

    }

    /// Responsible for reloading current Fruit List.
    @objc
    func reload() {
        presenter.loadIfRequired()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        /// On Transition animation finish invalidate collection view layout, to refresh layout.
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in

            guard let collectionView = self?.collectionView else {
                return
            }

            self?.invalidateCollectionViewLayout(collectionView)
        }
    }

    func invalidateCollectionViewLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout.invalidateLayout()
    }

    /// Responsible for reloading collection view by performing batch update.
    func reloadCollectionView(_ completion: @escaping ((Bool) -> Void)) {
        collectionView.reloadData()
        completion(true)
    }
    
}

extension MainViewController {

    enum Storyboard: String {
        case name = "MainStoryboard"
    }

}
