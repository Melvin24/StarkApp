//
//  JobsViewModel.swift
//  Stark
//
//  Created by Melvin John on 18/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

struct JobsViewModel {

    struct JobViewModel: Decodable {

        enum Status: String, Decodable {
            case success
            case failed
            case building
            case unknown

            var color: UIColor {
                switch self {
                case .building:
                    return Colors.building

                case .failed:
                    return Colors.failedBuild

                case .success:
                    return Colors.successfulBuild

                case .unknown:
                    return Colors.unknown

                }
            }

        }

        var name: String
        var status: Status

        var pulsingViewColor: UIColor {
            return status.color
        }

        var statusViewColor: UIColor {
            if status == .building {
                return .white
            } else {
                return pulsingViewColor
            }
        }

        var shouldAnimateStatus: Bool {
            return status == .building
        }
    }

    var pullRequests: [JobViewModel]
    var master: JobViewModel
    var releases: [JobViewModel]
}

struct JobsViewModelFactory {
    let jobs: Jobs

    func make() -> JobsViewModel {

        let masterJob = jobs.master

        let masterJobViewModel = JobsViewModel.JobViewModel(name: masterJob.name.capitalizingFirstLetter(),
                                                            status: viewModelStatus(fromJobStatus: masterJob.status))

        let prJobViewModels = jobs.pullRequests.map {
            return JobsViewModel.JobViewModel(name: $0.name,
                                              status: viewModelStatus(fromJobStatus: $0.status))
        }

        let releasesJobViewModels = jobs.releases.map {
            return JobsViewModel.JobViewModel(name: $0.name,
                                              status: viewModelStatus(fromJobStatus: $0.status))
        }

        return JobsViewModel(pullRequests: prJobViewModels,
                             master: masterJobViewModel,
                             releases: releasesJobViewModels)

    }

    private func viewModelStatus(fromJobStatus status: Jobs.Job.Status) -> JobsViewModel.JobViewModel.Status {
        switch status {
        case .building:
            return .building

        case .failed:
            return .failed

        case .success:
            return .success

        case .unknown:
            return .unknown

        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}


