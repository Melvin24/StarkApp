//
//  NetworkServiceError.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import Foundation

/// Common Network service error
enum NetworkServiceError: Error {

    /// No Connection Error
    case noConnection

    /// Unable to build a URL Type
    case couldNotBuildURL(URLPath: String)

    /// HTTP Error
    case HTTPError(type: HTTPURLResponse.ResponseType)

}
