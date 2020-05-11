//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/2/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation

extension Double {
    
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
    
}
