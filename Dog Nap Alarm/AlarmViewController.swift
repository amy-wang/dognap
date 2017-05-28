//
//  MainViewController.swift
//  Dog Nap Alarm
//
//  Created by Yucen Zhang on 2017-05-27.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    var seconds = 60
    var timer = Timer()
    var resumeTapped = false
    var isTimerunning = false
    
    
    // method for counting down
    func runtimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AlarmViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    @IBAction func timeSlider(_ sender: UISlider) {
        seconds = Int(sender.value)
        timerLabel.text = String(seconds)
    }
   
    @IBOutlet weak var startOutlet: UIButton!
    // Start Button function
    @IBAction func startBtn(_ sender: UIButton) {
        runtimer()
        startOutlet.isHidden = true
        sliderOutlet.isHidden = true
        stopOutlet.isHidden = false
        cancelOutlet.isHidden = false
    }
    
    // function to update timer
    func updateTimer(){
        seconds -= 1 //this will decrement the time
        timerLabel.text = String(seconds)
        
        if(seconds == 0){
            timer.invalidate()
        }
    }
    
    
    @IBOutlet weak var stopOutlet: UIButton!
    
    // Stop Button function
    @IBAction func stopBtn(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runtimer()
            self.resumeTapped = false
        }
    }
    
    
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBAction func cancelBtn(_ sender: UIButton) {
        timer.invalidate()
        seconds = 30
        sliderOutlet.setValue(30, animated: true)
        timerLabel.text = "30"
        startOutlet.isHidden = false
        sliderOutlet.isHidden = false
        stopOutlet.isHidden = true
        cancelOutlet.isHidden = true

    }
    
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
