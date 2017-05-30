//
//  MainViewController.swift
//  Dog Nap Alarm
//
//  Created by Yucen Zhang on 2017-05-27.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class AlarmViewController: UIViewController {
    
    //IB outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var snoozeOutlet: UIButton!
    @IBOutlet weak var stopAlarmOutlet: UIButton!
    @IBOutlet weak var dogSpeech: UILabel!

    //varibles
    var player:AVAudioPlayer = AVAudioPlayer()
    var mins = 30
    var seconds = 1800
    var timer = Timer()
    var resumeTapped = false
    var isTimerunning = false
    var snoozeTime = 5
   
    // method for counting down
    func runtimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AlarmViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    // function to update timer
    func updateTimer(){
        if(seconds == 0){
            timer.invalidate()
            player.play()
            startOutlet.isHidden = true
            sliderOutlet.isHidden = true
            pauseOutlet.isHidden = true
            cancelOutlet.isHidden = true
            stopAlarmOutlet.isHidden = false
            snoozeOutlet.isHidden = false
        }else{
            seconds -= 10     //this will decrement the time
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }

    // function to format string
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
    // Slider for choosing a time
    @IBAction func timeSlider(_ sender: UISlider) {
        mins = Int(sender.value)
        seconds = mins * 60
        let date = Date()
        let calendar = Calendar.current
        // Getting current time
        let currHour = calendar.component(.hour, from: date)
        let currMin = calendar.component(.minute, from: date)
        let currSec = calendar.component(.second, from: date)
        let totalSec = currHour * 3600 + currMin * 60 + currSec + seconds
        // Getting update time
        let newHour = totalSec / 3600
        let newMin = totalSec / 60 % 60
        timerLabel.text = String(mins) + ":00"
        dogSpeech.text = "You will wake up at: " + String(format:"%02i:%02i", newHour, newMin)
        
    }
   
   
    // Start Button function
    @IBAction func startBtn(_ sender: UIButton) {
        runtimer()
        startOutlet.isHidden = true
        sliderOutlet.isHidden = true
        pauseOutlet.isHidden = false
        cancelOutlet.isHidden = false
    }
    
    
    // Pause Button function
    @IBAction func pauseBtn(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseOutlet.setTitle("RESUME",for: .normal)
        } else {
            runtimer()
            self.resumeTapped = false
            self.pauseOutlet.setTitle("PAULSE",for: .normal)
        }
    }
    
    
    // cancel Button function
    @IBAction func cancelBtn(_ sender: UIButton) {
        timer.invalidate()
        mins = 30
        seconds = 1800
        sliderOutlet.setValue(30, animated: true)
        timerLabel.text = "30:00"
        self.resumeTapped = false
        startOutlet.isHidden = false
        sliderOutlet.isHidden = false
        pauseOutlet.isHidden = true
        cancelOutlet.isHidden = true

    }
    
    @IBAction func stopBtn(_ sender: UIButton) {
        timer.invalidate()
        player.stop()
        mins = 30
        seconds = 1800
        sliderOutlet.setValue(30, animated: true)
        timerLabel.text = "30:00"
        self.resumeTapped = false
        
        startOutlet.isHidden = false
        sliderOutlet.isHidden = false
        pauseOutlet.isHidden = true
        cancelOutlet.isHidden = true
        stopAlarmOutlet.isHidden = true
        snoozeOutlet.isHidden = true
    }
 
    @IBAction func snoozeBtn(_ sender: UIButton) {
        timer.invalidate()
        player.stop()
        mins = snoozeTime
        seconds = mins*60
        self.resumeTapped = false
        startOutlet.isHidden = true
        sliderOutlet.isHidden = true
        pauseOutlet.isHidden = false
        cancelOutlet.isHidden = false
        stopAlarmOutlet.isHidden = true
        snoozeOutlet.isHidden = true
        runtimer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do{
            let audioPath = Bundle.main.path(forResource: "sound1", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf:URL(fileURLWithPath:audioPath!))
        }
        catch{
            //Error
        }
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
