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
        var name: String
        var status: String
        var url: String
    }

    var pullRequests: [Job]
    var master: Job
    var releases: [Job]

}
