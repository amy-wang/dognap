//
//  SoundTableViewController.swift
//  Dog Nap Alarm
//
//  Created by Amy Wang on 2017-05-30.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

class SoundTableViewController: UITableViewController {
    
    
    let settings = UserDefaults.standard
    var alarmSounds = ["sound1", "sound2", "sound3"]
    var snoozeTime = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var defaultTime = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(_ animated: Bool) {
        var indexPath = IndexPath(row: 0, section: 0)
        if (settings.string(forKey: "settingValue") == "Sound"){
            let value = settings.string(forKey: "Sound")
            print(value!)
            let index = alarmSounds.index(of: value!)
            indexPath = IndexPath(row: index!, section: 0)
        }
        else if (settings.string(forKey: "settingValue") == "Snooze"){
            let value = settings.integer(forKey: "Snooze")
            let index = snoozeTime.index(of: value)
            indexPath = IndexPath(row: index!, section: 0)
        }
        else{
            let value = settings.integer(forKey: "Default Time")
            let index = defaultTime.index(of: value)
            indexPath = IndexPath(row: index!, section: 0)
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if (settings.string(forKey: "settingValue") == "Sound"){
            count = alarmSounds.count
        }
        else if (settings.string(forKey: "settingValue") == "Snooze"){
            count = snoozeTime.count
        }
        else{
            count = defaultTime.count
        }
        return count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configuring cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if (settings.string(forKey: "settingValue") == "Sound"){
            let value = alarmSounds[indexPath.row]
            cell.textLabel?.text = value
        }
        else if (settings.string(forKey: "settingValue") == "Snooze"){
            let value = String(snoozeTime[indexPath.row])
            cell.textLabel?.text = value + " min"
        }
        else{
            let value = String(defaultTime[indexPath.row])
            cell.textLabel?.text = value + " min"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        if (settings.string(forKey: "settingValue") == "Sound"){
            let value = alarmSounds[indexPath.row]
            settings.set(value, forKey: "Sound")
            print(value)
        }
        else if (settings.string(forKey: "settingValue") == "Snooze"){
            let value = snoozeTime[indexPath.row]
            settings.set(value, forKey: "Snooze")
            print(value)
        }
        else{
            let value = defaultTime[indexPath.row]
            settings.set(value, forKey: "Default Time")
            print(value)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
