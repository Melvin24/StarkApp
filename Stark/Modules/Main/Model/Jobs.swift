//
//  Jobs.swift
//  Stark
//
//  Created by Melvin John on 17/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import Foundation

struct Jobs: Decodable {

    struct Job: Decodable {

        enum Status: String, Decodable {
            case success
            case failed
            case building
            case unknown
        }
        
        var name: String
        var status: Status
        var url: String
    }

    var pullRequests: [Job]
    var master: Job
    var releases: [Job]

}
