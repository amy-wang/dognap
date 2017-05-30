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

    
    var settingsArray = ["Sound", "Snooze", "Default Nap Length", "Vibrate"]
    var snoozeTime = ["1 min", "2 min", "3 min", "4 min", "5 min", "6 min", "7 min", "8 min", "9 min", "10 min", "11 min", "12 min", "13 min", "14 min", "15 min"]
    var defaultTime = ["5 min", "10 min", "15 min", "20 min", "25 min", "30 min", "35 min", "40 min", "45 min", "50 min", "55 min", "60 min"]
    var snoozeData: Bool = false
    
    let settings = UserDefaults.standard
    
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
            return snoozeTime[row]
        }
        else{
            return defaultTime[row]
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

