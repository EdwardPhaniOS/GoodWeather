//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/2/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    
    private(set) var weatherViewModels = [WeatherViewModel]()
}

extension WeatherListViewModel {
    
    func numberOfRow(inSection section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func viewModelForIndexPath(at index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    func addWeatherViewModel(viewModel: WeatherViewModel) {
        weatherViewModels.append(viewModel)
    }
    
    private func toCelcius() {
        
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value - 32) * 5/9
            
            return weatherModel
        }
    }
    
    private func toFahrenheit() {
           
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value * 9/5) + 32
            
            return weatherModel
        }
    }
    
    func updateUnit(to unit: Unit) {
        
        switch unit {
        case .celsius:
            self.toCelcius()
        case .fahrenheit:
            self.toFahrenheit()
        }
        
    }
}

//Type Eraser
//
class Dynamic<T>: Decodable where T: Decodable {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}

struct WeatherViewModel: Decodable {
    
    var currentTemperature: TemperatureViewModel
    let name: Dynamic<String>
    
    init(currentTemperature: TemperatureViewModel, name: Dynamic<String>) {
        self.currentTemperature = currentTemperature
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic<String>(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
    }
    
    private enum CodingKeys: String, CodingKey {
        case currentTemperature = "main"
        case name
    }
}

struct TemperatureViewModel: Decodable {
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    init(temperature: Dynamic<Double>, temperatureMin: Dynamic<Double>, temperatureMax: Dynamic<Double>) {
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax)) 
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
