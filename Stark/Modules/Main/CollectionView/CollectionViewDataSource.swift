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
            return 1
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

        if indexPath.section == 0 {
            cell.jobNameLabel.text = jobs.master.name
            setupCell(cell, forJob: jobs.master)

        } else if indexPath.section == 1 {
            cell.jobNameLabel.text = jobs.pullRequests[indexPath.row].name
            setupCell(cell, forJob: jobs.pullRequests[indexPath.row])

        } else if indexPath.section == 2 {
            cell.jobNameLabel.text = jobs.releases[indexPath.row].name
            setupCell(cell, forJob: jobs.releases[indexPath.row])

        }

        return cell

    }

    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, type: JobHeaderCollectionReusableView.self, forIndexPath: indexPath)

            if indexPath.section == 1 {
                headerView.headerLabel.text = "Pull Requests"
                headerView.headerLabel.textColor = .white

            } else if indexPath.section == 2 {
                headerView.headerLabel.text = "Releases"
                headerView.headerLabel.textColor = .white

            } else {
                return UICollectionReusableView()
            }

            return headerView

        default:
            return UICollectionReusableView()
        }


    }

    func setupCell(_ cell: JobCollectionViewCell, forJob job: Jobs.Job) {

//        let circleView = UIView()// (frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//
//        circleView.translatesAutoresizingMaskIntoConstraints = false
//
//        circleView.layer.cornerRadius = view.frame.width/2


        switch job.status {
        case .building:
            cell.statusView.backgroundColor = UIColor(red:0.82, green:0.83, blue:0.86, alpha:1.0) // lightGrey
        case .failed:
            cell.statusView.backgroundColor = UIColor(red:0.65, green:0.07, blue:0.07, alpha:1.0)

        case .success:
            cell.statusView.backgroundColor = UIColor(red:0.05, green:0.52, blue:0.15, alpha:1.0)

        case .unknown:
            cell.statusView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:1.0) // black

        }

//        view.addSubview(circleView)
//
//        NSLayoutConstraint.activate([
//            circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            circleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            circleView.topAnchor.constraint(equalTo: view.topAnchor),
//            circleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])


    }
}

