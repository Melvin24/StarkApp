//
//  MainInteractor.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import Foundation

class MainInteractor: Interactor {

    /// Current Task.
    var task: Task?

    /// Request type
    typealias RequestType = JobsNetworkService.Request

    /// Request to use when fetching data.
    let request: RequestType

    /// Initialize FruitListInteractor with a request.
    ///
    /// - Parameter request: Request to use when fetching data
    init(withRequest request: @escaping RequestType) {
        self.request = request
    }

    /// Call this method to fetch data.
    ///
    /// - Parameters:
    ///   - completion: Completion block, called on request completion.
    func fetchData(completion: @escaping (Result<Jobs>) -> Void) {

        guard task == nil || task?.isRunning == false else {
            return
        }

        do {

            task = try request { result in
                completion(result)
            }

            task?.resume() // Resume task

        } catch let error {
            completion(.failure(error))
        }

    }

}
