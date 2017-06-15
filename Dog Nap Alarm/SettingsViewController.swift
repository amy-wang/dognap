//
//  SettingsViewController.swift
//  Dog Nap Alarm
//
//  Created by Amy Wang on 2017-05-27.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UITableViewController, MFMailComposeViewControllerDelegate{
    
    //IB outlets
    @IBOutlet weak var snoozeDetail: UILabel!
    @IBOutlet weak var defaultTimeDetail: UILabel!
    @IBOutlet weak var dogDetail: UILabel!
    @IBOutlet weak var soundDetail: SettingsDetailUILabel!

    // variables
    let settings = UserDefaults.standard // for storing setting values
    var settingsArray = ["Sound", "Snooze", "Default Nap Length"]
    var snoozeData: Bool = false
    
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // default value 
        settings.set("sound1", forKey: "Sound")
        settings.set(1, forKey: "Snooze")
        settings.set(10, forKey: "Default Time")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        soundDetail.text = settings.string(forKey: "Sound")
        dogDetail.text = settings.string(forKey: "dogName")
        snoozeDetail.text = String(settings.integer(forKey: "Snooze")) + " min"
        defaultTimeDetail.text = String(settings.integer(forKey: "Default Time")) + " min"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function to configure mail
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["rainpillarstudios@gmail.com"])
        mailComposerVC.setSubject("App Feedback")
        mailComposerVC.setMessageBody("Hi team! \n\n I would like to share the following feedback: \n", isHTML: false)
        
        return mailComposerVC
        
    }
    
    // function to check if there is an error with email
    func emailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "Email couldn't send", message: "Check your email configurations and try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(okAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // function to dismiss mail when done
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }

    // function to show mail option
    func sendMail(){
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            self.emailErrorAlert()
        }
    }
    
    
    // function that calls
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.text

        if (text=="Snooze"){
            settings.set("Snooze", forKey: "settingValue")
        }
        else if (text == "Sound"){
            settings.set("Sound", forKey: "settingValue")
        }
        else if (text=="Default Nap Length"){
            settings.set("Default Nap Length", forKey: "settingValue")
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

