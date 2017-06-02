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
    var alarmSounds = ["Sound 1", "Sound 2", "Sound 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return alarmSounds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configuring cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sound Cell", for: indexPath)
        let sound = alarmSounds[indexPath.row]
        cell.textLabel?.text = sound
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        let sound = alarmSounds[indexPath.row]
        settings.set(sound, forKey: "Sound")
        print(sound)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
