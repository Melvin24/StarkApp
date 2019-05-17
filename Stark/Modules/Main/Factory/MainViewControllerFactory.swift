//
//  MainViewControllerFactory.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

class MainViewControllerFactory {

    func make() throws -> UIViewController {
        guard let mainViewController = UIStoryboard.instantiateViewControllerFromStoryboard(withName: MainViewController.Storyboard.name) as? MainViewController else {
            throw CoordinateError.unsupported("Coordination isnt supported")

        }


        let presenter = MainPresenter(viewController: mainViewController,
                                      interactor: MainInteractor(withRequest: JobsNetworkService().fetchFruitData(session: .shared)))

        mainViewController.presenter = presenter

        return mainViewController

    }

}
