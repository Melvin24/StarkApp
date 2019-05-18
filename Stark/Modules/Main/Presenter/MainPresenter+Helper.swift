//
//  MainPresenter+Helper.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

extension MainPresenter {

    /// Call this method to obtain a loading view.
    ///
    /// - Returns: Loading View.
    func loadingView() -> UIView {
        return UIView.loadViewFromNib(as: LoadingView.self)
    }

    /// Call this method to obtain a No Data Error View.
    ///
    /// - Returns: An Error View with appropriate label text.
    func noDataView() -> UIView {
        let errorView = errorStatusView()
        errorView.label.text = "No response"
        errorView.onRetryButtonSelect = self.viewController?.reload

        return errorView
    }

    /// Call this method to obtain an Error view for a given Error.
    ///
    /// - Parameter error: Error to use, to construct Error View.
    /// - Returns: Error View with appropriate label text.
    func errorView(forError error: Error) -> UIView {

        let errorView = errorStatusView()

        errorView.onRetryButtonSelect = self.viewController?.reload

        let errorLabel: String

        if let jobsNetworkingError = error as? JobsNetworkService.JobsNetworkingError {
            errorLabel = errorMessage(forError: jobsNetworkingError)
        } else if let networkError = error as? NetworkServiceError {
            errorLabel = errorMessage(forError: networkError)
        } else {
            errorLabel = "Unexpected Error"
        }

        errorView.label.text = errorLabel

        return errorView

    }

    func errorMessage(forError error: JobsNetworkService.JobsNetworkingError) -> String {

        switch error {
        case .noData:
            return "No response"
        case .unableToParseData:
            return "Invalid response from API"
        }
    }

    func errorMessage(forError error: NetworkServiceError) -> String {

        switch error {
        case .noConnection:
            return "No connection"
        case .couldNotBuildURL, .HTTPError:
            return "Unexpected Error"

        }
    }

    private func errorStatusView() -> ErrorView {
        return UIView.loadViewFromNib(as: ErrorView.self)
    }

}
