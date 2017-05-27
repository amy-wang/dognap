//
//  MainViewController.swift
//  Dog Nap Alarm
//
//  Created by Yucen Zhang on 2017-05-27.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func settingsPage(){
        let storyboard = UIStoryboard(name: "settings", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "settings")
        self.present(controller, animated: true, completion: nil)
    }

    
}
