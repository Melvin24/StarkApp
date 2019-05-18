//
//  CollectionViewDataSource.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

    @IBOutlet weak var viewController: MainViewController!

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        guard let jobs = viewController.presenter.jobs else {
            return 0
        }

        let pullRequestCount = jobs.pullRequests.isEmpty ? 0 : 1
        let masterCount = 1
        let releaseCounts = jobs.releases.isEmpty ? 0: 1

        return pullRequestCount + masterCount + releaseCounts

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        guard let jobs = viewController.presenter.jobs else {
            return 0
        }

        if section == 0 {
            return 0
        } else if section == 1 {
            return jobs.pullRequests.count
        } else if section == 2 {
            return jobs.releases.count
        } else {
            return 0
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let jobs = viewController.presenter.jobs else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeueReusableCell(type: JobCollectionViewCell.self, forIndexPath: indexPath)

        if indexPath.section == 1 {
            cell.statusView.backgroundColor = .white
            setupCell(cell, forJob: jobs.pullRequests[indexPath.row])

        } else if indexPath.section == 2 {
            cell.statusView.backgroundColor = .white
            setupCell(cell, forJob: jobs.releases[indexPath.row])

        }

        return cell

    }

    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let jobs = viewController.presenter.jobs else {
            return UICollectionReusableView()
        }

        switch (kind, indexPath.section) {

        case (UICollectionView.elementKindSectionHeader, 0):
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, type: MasterHeaderCollectionReusableView.self, forIndexPath: indexPath)
            headerView.nameLabel.text = jobs.master.name
            headerView.pulsingView.backgroundColor = jobs.master.pulsingViewColor
            headerView.statusView.backgroundColor = jobs.master.statusViewColor
            
            return headerView


        case (UICollectionView.elementKindSectionHeader, 1):
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, type: JobHeaderCollectionReusableView.self,
                                                                             forIndexPath: indexPath)

            headerView.headerLabel.text = "Pull Requests"
            headerView.headerLabel.textColor = .white

            return headerView

        case (UICollectionView.elementKindSectionHeader, 2):
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, type: JobHeaderCollectionReusableView.self,
                                                                             forIndexPath: indexPath)

            headerView.headerLabel.text = "Releases"
            headerView.headerLabel.textColor = .white


            return headerView

        default:
            return UICollectionReusableView()
        }


    }

    func setupCell(_ cell: JobCollectionViewCell, forJob job: JobsViewModel.JobViewModel) {

        cell.jobNameLabel.text = job.name
        cell.pulsingView.backgroundColor = job.pulsingViewColor

    }

}

