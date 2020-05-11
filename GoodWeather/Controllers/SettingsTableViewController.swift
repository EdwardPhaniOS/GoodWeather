//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/4/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation
import UIKit

protocol SettingDelegate {
    func settingsDone(vm: SettingsViewModel)
}


class SettingsTableViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    
    var delegate: SettingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    @IBAction func done() {
        
        if let safeDelegate = delegate {
            safeDelegate.settingsDone(vm: settingsViewModel)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsItem = self.settingsViewModel.units[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        cell.textLabel?.text = settingsItem.displayName
        
        if settingsItem == self.settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //uncheck all cells
        
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
        let unit = Unit.allCases[indexPath.row]
        self.settingsViewModel.selectedUnit = unit
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deSelectedCell = tableView.cellForRow(at: indexPath)
        deSelectedCell?.accessoryType = .none
    }
}
