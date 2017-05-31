//
//  SettingsViewController.swift
//  Dog Nap Alarm
//
//  Created by Amy Wang on 2017-05-27.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var vibrate: UISwitch!
    @IBOutlet weak var snoozeDone: UIButton!
    @IBOutlet var picker: UITableView!
    @IBOutlet weak var snoozeDetail: UILabel!
    @IBOutlet weak var defaultTimeDetail: UILabel!
    @IBOutlet weak var soundDetail: UITableViewCell!

    let settings = UserDefaults.standard // for storing setting values
    var settingsArray = ["Sound", "Snooze", "Default Nap Length", "Vibrate"]
    var snoozeTime = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var defaultTime = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]
    var snoozeData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snoozeDetail.text = String(settings.integer(forKey: "Snooze")) + " min"
        defaultTimeDetail.text = String(settings.integer(forKey: "Default Time")) + " min"
        picker.isHidden = true
        snoozeDone.isHidden = true
        picker.dataSource = self
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displaySnooze(){
        snoozeData = true
        picker.reloadData()
        picker.isHidden = false
        snoozeDone.isHidden = false
    }
    
    //
    func displayDefault(){
        snoozeData = false
        picker.reloadData()
        picker.isHidden = false
        snoozeDone.isHidden = false
    }
    
    // call when done button is clicked
    @IBAction func doneSnoozeClick(_ sender: Any) {
        picker.isHidden = true
        snoozeDone.isHidden = true
    }
    
    // called when vibrate switch is changed
    @IBAction func vibrateButtonChange(_ sender: UISwitch) {
        if self.vibrate.isOn{
            settings.set(true, forKey: "Vibrate")
            print("on")
        }
        else{
            settings.set(false, forKey: "Vibrate")
            print("off")
        }
    }

    
    // configuring mail
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["rainpillarstudios@gmail.com"])
        mailComposerVC.setSubject("App Feedback")
        mailComposerVC.setMessageBody("Hi team! \n\n I would like to share the following feedback: \n", isHTML: false)
        
        return mailComposerVC
        
    }
    
    // check if there is an error with email
    func emailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "Email couldn't send", message: "Check your email configurations and try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(okAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // dismiss mail when done
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }

    // show mail option
    func sendMail(){
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            self.emailErrorAlert()
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
        // Create a picker based on selected item (either snooze or default)
        if snoozeData{
            return String(snoozeTime[row]) + " min"
        }
        else{
            return String(defaultTime[row]) + " min"
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if snoozeData{
            settings.set(snoozeTime[row], forKey: "Snooze")
            snoozeDetail.text = String(settings.integer(forKey: "Snooze")) + " min"
            print(snoozeTime[row])
        }
        else{
            settings.set(defaultTime[row], forKey: "Default")
            defaultTimeDetail.text = String(defaultTime[row]) + " min"
            print(defaultTime[row])
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.text

        if (text=="Snooze"){
            displaySnooze()
        }
        else if (text=="Default Nap Length"){
            displayDefault()
        }
        // pop up opens if rate/feedback clicked
        else if (text=="Rate/Feedback"){
            let alert = UIAlertController(title: "Dog Nap", message: "Did you enjoy using this app?" , preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            let noAction = UIAlertAction(title: "No", style: .default, handler: {action in
                self.sendMail()
            })
            let backAction = UIAlertAction(title: "Back", style: .default, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            alert.addAction(backAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }

    
}

