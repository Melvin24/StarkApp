//
//  MainViewController+PresenterDelegate.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

extension MainViewController: PresenterDelegate {

    func presenterWillUpdateContent() {
        if !refreshControl.isRefreshing {
            DispatchQueue.main.async { [weak self] in
                self?.changeStatusView(with: self?.presenter.loadingView())
            }
        }
    }

    func presenterDidUpdateContent() {

        var statusView: UIView?
        if presenter.jobs == nil, !refreshControl.isRefreshing {
            statusView = presenter.noDataView()
        }

        DispatchQueue.main.async { [weak self] in
            self?.reloadCollectionView() { [weak self] _ in
                self?.refreshControl.endRefreshing()
                self?.changeStatusView(with: statusView)
            }
        }
    }

    func presenterDidFail(withError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.changeStatusView(with: self?.presenter.errorView(forError: error))
        }
    }

}
