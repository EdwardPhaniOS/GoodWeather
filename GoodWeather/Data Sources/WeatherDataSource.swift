//
//  WeatherDataSource.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/11/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation
import UIKit

//Create Custom WeatherDataSource (phuc vu 1 tableview nen ta co the tuy y them, chinh sua)
//
class WeatherDataSource: NSObject, UITableViewDataSource {
    
    let cellIdentifier: String = "WeatherCell"
    private var weatherListViewModel: WeatherListViewModel
    
    init(weatherListViewModel: WeatherListViewModel) {
        self.weatherListViewModel = weatherListViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? WeatherCell else {
            fatalError("\(self.cellIdentifier) not found")
        }
        
        let weatherVM = self.weatherListViewModel.viewModelForIndexPath(at: indexPath.row)
        
        cell.cityNameLabel.text = weatherVM.name.value
        cell.temperatureLabel.text = weatherVM.currentTemperature.temperature.value.formatAsDegree
        
        return cell
    }
}


