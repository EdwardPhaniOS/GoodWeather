//
//  WeatherDetailViewController.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/7/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVMBidings()
    }
    
    func setupVMBidings() {
        if let weatherVM = weatherViewModel {
            weatherVM.name.bind { self.cityNameLabel.text = $0 }
            
            weatherVM.currentTemperature.temperature.bind { (result) in
                self.currentTemperatureLabel.text = result.formatAsDegree
            }
            
            weatherVM.currentTemperature.temperatureMax.bind {
                self.maxTempLabel.text = $0.formatAsDegree
            }
            
            weatherVM.currentTemperature.temperatureMin.bind {
                self.minTempLabel.text = $0.formatAsDegree
            }
        }
        
        //Change the name.value after 2s to show you View Model binding to View
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.weatherViewModel?.name.value = "Danang"
        }
    }

}
