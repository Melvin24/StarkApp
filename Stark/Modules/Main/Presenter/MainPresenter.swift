//
//  MainPresenter.swift
//  Stark
//
//  Created by Melvin John on 14/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import Foundation

class MainPresenter: Presenter {

    weak var viewController: MainViewController?

    /// Associated Interactor.
    var interactor: MainInteractor

    init(viewController: MainViewController, interactor: MainInteractor) {
        self.viewController = viewController
        self.interactor = interactor
    }


    var jobs: JobsViewModel?

    func loadIfRequired() {

        presenterWillUpdateContent(self.viewController)

        interactor.fetchData { [weak self] result in

            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let jobs):
                strongSelf.jobs = jobs
                strongSelf.presenterDidUpdateContent(strongSelf.viewController)
            case .failure(let error):
                strongSelf.presenterDidFailWithError(strongSelf.viewController, error)
            }
        }

    }

    var presenterWillUpdateContent: ((PresenterDelegate?) -> Void) = { presenterDelegate in
        presenterDelegate?.presenterWillUpdateContent()
    }

    var presenterDidUpdateContent: ((PresenterDelegate?) -> Void) = { presenterDelegate in
        presenterDelegate?.presenterDidUpdateContent()
    }

    var presenterDidFailWithError: ((PresenterDelegate?, Error) -> Void) = { presenterDelegate, error in
        presenterDelegate?.presenterDidFail(withError: error)
    }
    
}
