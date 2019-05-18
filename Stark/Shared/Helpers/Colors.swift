//
//  Colors.swift
//  Stark
//
//  Created by Melvin John on 18/05/2019.
//  Copyright © 2019 melvin. All rights reserved.
//

import UIKit

struct Colors {

    static var collectionViewBackground: UIColor {
        return UIColor(red:0.89, green:0.89, blue:0.90, alpha:1.0)
    }

    static var successfulBuild: UIColor {
        return UIColor(red:0.05, green:0.52, blue:0.15, alpha:1.0)
    }

    static var failedBuild: UIColor {
        return UIColor(red:0.65, green:0.07, blue:0.07, alpha:1.0)
    }

    static var unknown: UIColor {
        return .black
    }

    static var building: UIColor {
        return UIColor(red:0.04, green:0.38, blue:1.00, alpha:1.0)
    }
}
