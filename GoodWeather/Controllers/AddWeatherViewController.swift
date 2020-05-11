//
//  AddWeatherViewController.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 4/30/20.
//  Copyright © 2020 PTV. All rights reserved.
//
////http://api.openweathermap.org/data/2.5/weather?q=Saigon&appid=d6bfb8d977a825aeb92cb1aa0e2b869e&units=metric

import Foundation
import UIKit

protocol AddWeatherDelegate: class {
    
    func addWeatherDidSave(weatherViewModel: WeatherViewModel)
}

class AddWeatherViewController: UIViewController {
    
    private var addCityViewModel = AddCityViewModel()
    
    //View to View Model Biding = Khi View thay doi, View Model se tu dong thay doi theo
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet {
            self.stateTextField.bind {
                self.addCityViewModel.state = $0
            }
        }
    }
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet {
            self.zipCodeTextField.bind {
                self.addCityViewModel.zipCode = $0
            }
        }
    }
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            self.cityNameTextField.bind {
                //$0: Tham so dau tien cua closure
                //$1: Tham so thu 2 cua closure
                self.addCityViewModel.city = $0
            }
        }
    }
    
    weak var delegate: AddWeatherDelegate?
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        print(self.addCityViewModel)
        
        if let cityName = cityNameTextField.text {
            
            guard let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=d6bfb8d977a825aeb92cb1aa0e2b869e&units=metric") else {
                return
            }
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherUrl) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                
                return weatherVM
            }
            
            Webservice().load(resource: weatherResource) { (result) in
             
                if let weatherVM = result {
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.addWeatherDidSave(weatherViewModel: weatherVM)
                }
            }
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
