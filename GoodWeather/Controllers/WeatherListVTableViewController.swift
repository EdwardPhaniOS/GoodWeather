//
//  WeatherListVTableViewController.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 4/30/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController {
    
    private var weatherListVM = WeatherListViewModel()
    private var datasource: TableViewDataSource<WeatherCell, WeatherViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.datasource = TableViewDataSource<WeatherCell, WeatherViewModel>(cellIdentifier: "WeatherCell", items: self.weatherListVM.weatherViewModels, configureCell: { (cell, vm) in
            
            cell.cityNameLabel.text = vm.name.value
            cell.temperatureLabel.text = vm.currentTemperature.temperature.value.formatAsDegree
        })
        
        self.tableView.dataSource = self.datasource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "AddWeatherViewController" {
            prepareSegueForAddWeatherViewController(segue: segue)
        } else if segue.identifier == "SettingsTableViewController" {
            prepareSegueForSettingsTableViewController(segue: segue)
        } else if segue.identifier == "WeatherDetailViewController" {
            prepareSegueForWeatherDetailViewController(segue: segue)
        }
    }
    
    func prepareSegueForWeatherDetailViewController(segue: UIStoryboardSegue) {
        
        guard let weatherDetailsVC = segue.destination as? WeatherDetailViewController,
            let indexPath = self.tableView.indexPathForSelectedRow
            else { return }
        
        let weatherVM = self.weatherListVM.viewModelForIndexPath(at: indexPath.row)
        weatherDetailsVC.weatherViewModel = weatherVM
    }
    
    private func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {
        
        if let navController =  segue.destination as? UINavigationController {
            if let settingsVC = navController.viewControllers.first as? SettingsTableViewController {
                settingsVC.delegate = self
            } else {
                fatalError("SettingsTableViewController not found")
            }
        } else {
            fatalError("NavigationController not found")
        }
    }
    
    private func prepareSegueForAddWeatherViewController(segue: UIStoryboardSegue) {
        
        if let navController =  segue.destination as? UINavigationController {
            if let addWeatherVC = navController.viewControllers.first as? AddWeatherViewController {
                addWeatherVC.delegate = self
            } else {
                fatalError("AddWeatherViewController not found")
            }
        } else {
            fatalError("NavigationController not found")
        }
    }
}


//
//MARK: - AddWeatherDelegate
//
extension WeatherListTableViewController: AddWeatherDelegate {
    func addWeatherDidSave(weatherViewModel: WeatherViewModel) {
        
        weatherListVM.addWeatherViewModel(viewModel: weatherViewModel)
        
        //Array is a Value type (not reference type) ==> Khi weatherViewModels append them 1 item array items trong datasource khong tu dong append them 1 item ==> ta can update Items trong datasource theo weatherViewModels moi nhat
        self.datasource?.updateItems(self.weatherListVM.weatherViewModels)
        self.tableView.reloadData()
    }
}

extension WeatherListTableViewController: SettingDelegate {
    func settingsDone(vm: SettingsViewModel) {
        print("Done...")
        self.weatherListVM.updateUnit(to: vm.selectedUnit)
        tableView.reloadData()
    }
}
