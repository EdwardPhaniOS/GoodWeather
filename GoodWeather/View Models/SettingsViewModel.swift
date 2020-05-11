//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/4/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }
}

struct SettingsViewModel {
    let units = Unit.allCases
    private var _selectedUnit: Unit = .fahrenheit
    
    var selectedUnit: Unit {
        get {
            
            let userDefault = UserDefaults.standard
            if let value = userDefault.value(forKey: "unit") as? String {
                return Unit(rawValue: value)!
            }
            
            return _selectedUnit
        }
        
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey: "unit")
        }
    }
    
}

