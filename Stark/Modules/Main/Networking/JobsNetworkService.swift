//
//  JobsNetworkService.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import Foundation

/// Responsible for performing Network request to fetch fruit data.
class JobsNetworkService {

    var URLPath = "https://api.myjson.com/bins/8ehye" //http://localhost:8080/api/ios/jobs"

    /// Network Error
    enum JobsNetworkingError: Error {

        /// No Data from Fruit Data API.
        case noData

        /// Failed to Parse Fruit API Response.
        case unableToParseData

    }

    typealias ResultType = Jobs

    typealias Completion = (Result<ResultType>) -> Void

    typealias Request = (@escaping Completion) throws -> Task

    /// Call this method to obtain a request to fetch fruit data.
    func fetchFruitData(session: URLSession) -> Request {

        return { completion in

            guard let fruitAPIURL = URL(string: self.URLPath) else {
                throw NetworkServiceError.couldNotBuildURL(URLPath: self.URLPath)
            }

            return session.dataTask(with: fruitAPIURL) { data, response, error in

                guard error?._code != NSURLErrorTimedOut && error?._code != NSURLErrorNotConnectedToInternet else {
                    completion(.failure(NetworkServiceError.noConnection))
                    return
                }

                guard let data = data else {
                    completion(.failure(JobsNetworkingError.noData))
                    return
                }

                guard let result = try? JSONDecoder().decode(ResultType.self, from: data) else {
                    completion(.failure(JobsNetworkingError.unableToParseData))
                    return
                }

                completion(.success(result))

            }
        }
    }
}
