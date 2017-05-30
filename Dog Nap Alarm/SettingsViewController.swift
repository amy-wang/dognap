//
//  SettingsViewController.swift
//  Dog Nap Alarm
//
//  Created by Amy Wang on 2017-05-27.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var vibrate: UISwitch!
    @IBOutlet weak var snoozeDone: UIButton!
    @IBOutlet var picker: UITableView!

    let settings = UserDefaults.standard

    var settingsArray = ["Sound", "Snooze", "Default Nap Length", "Vibrate"]
    var snoozeTime = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var defaultTime = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]
    var snoozeData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.isHidden = true
        snoozeDone.isHidden = true
        picker.dataSource = self
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func displaySnooze(){
        snoozeData = true
        picker.reloadData()
        picker.isHidden = false
        snoozeDone.isHidden = false
    }
    
    @IBAction func displayDefault(){
        snoozeData = false
        picker.reloadData()
        picker.isHidden = false
        snoozeDone.isHidden = false
    }
    
    @IBAction func doneSnoozeClick(_ sender: Any) {
        picker.isHidden = true
        snoozeDone.isHidden = true
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if self.vibrate.isOn{
            settings.set(true, forKey: "Vibrate")
            print("on")
        }
        else{
            settings.set(false, forKey: "Vibrate")
            print("off")
        }
    }
    
    // picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if snoozeData{
            return snoozeTime.count
        }
        else{
            return defaultTime.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if snoozeData{
            return String(snoozeTime[row]) + " min"
        }
        else{
            return String(defaultTime[row]) + " min"
        }
        
    }
    
    // change variable for snooze time user setting
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if snoozeData{
            settings.set(snoozeTime[row], forKey: "Snooze")
            print(snoozeTime[row])
        }
        else{
            settings.set(defaultTime[row], forKey: "Default")
            print(defaultTime[row])
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.text
        print(text!)
        if (text=="Snooze"){
            displaySnooze()
        }
        else if (text=="Default Nap Length"){
            displayDefault()
        }
    }
    
    // back button
    @IBAction func backToAlarm(){
        let storyboard = UIStoryboard(name: "alarm", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "sounds")
        self.present(controller, animated: true, completion: nil)
    }
    
}

