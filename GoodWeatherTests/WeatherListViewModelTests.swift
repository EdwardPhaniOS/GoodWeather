//
//  WeatherListViewModelTests.swift
//  GoodWeatherTests
//
//  Created by Tan Vinh Phan on 5/11/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import XCTest
@testable import GoodWeather

class WeatherListViewModelTests: XCTestCase {
    
    private var weatherListVM: WeatherListViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.weatherListVM = WeatherListViewModel()
        
        let temperatureVM = TemperatureViewModel(temperature: Dynamic<Double>(32), temperatureMin: Dynamic<Double>(32), temperatureMax: Dynamic<Double>(32))
        let weatherVM = WeatherViewModel(currentTemperature: temperatureVM, name: Dynamic<String>("Hanoi"))
        
        let temperatureVM2 = TemperatureViewModel(temperature: Dynamic<Double>(72), temperatureMin: Dynamic<Double>(72), temperatureMax: Dynamic<Double>(72))
        let weatherVM2 = WeatherViewModel(currentTemperature: temperatureVM2, name: Dynamic<String>("Saigon"))
        
        self.weatherListVM.addWeatherViewModel(viewModel: weatherVM)
        self.weatherListVM.addWeatherViewModel(viewModel: weatherVM2)
    }
    
    func test_should_be_able_to_convert_to_celcious_successufully() {
        
        let celciousTemperature = [0, 22.2222]
        self.weatherListVM.updateUnit(to: .celsius)
        
        for (index, vm) in self.weatherListVM.weatherViewModels.enumerated() {
            XCTAssertEqual(round(vm.currentTemperature.temperature.value), round(celciousTemperature[index]))
        }
        
    }
    
    
    override class func tearDown() {
        super.tearDown()
    }
    
}
