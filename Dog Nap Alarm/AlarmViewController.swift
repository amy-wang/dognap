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
import AudioToolbox

class AlarmViewController: UIViewController {
    
    //IB outlets
    @IBOutlet weak var imageDog: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var snoozeOutlet: UIButton!
    @IBOutlet weak var stopAlarmOutlet: UIButton!
    @IBOutlet weak var dogSpeech: UILabel!
    @IBOutlet weak var Setting_btn: UIButton!

    //Variables
    var player:AVAudioPlayer = AVAudioPlayer()
    var mins = 30
    var seconds = 1800
    var timer = Timer()
    var resumeTapped = false
    var isTimerunning = false
    var snoozeTime = 5
    let settingsPage = UserDefaults.standard
    var isVibrate = false
    var startAppBanner: STABannerView?
  
   
    // method for counting down
    func runtimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AlarmViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    // function to update timer
    func updateTimer(){
        if(seconds == 0){
            timer.invalidate()
            player.play()
            dogSpeech.text = "WAKE UP!"
            startOutlet.isHidden = true
            sliderOutlet.isHidden = true
            pauseOutlet.isHidden = true
            cancelOutlet.isHidden = true
            stopAlarmOutlet.isHidden = false
            snoozeOutlet.isHidden = false
        } else{
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
        if(newHour <= 12){
            dogSpeech.text = "You will wake up at " + String(format:"%02i:%02i AM", newHour, newMin)
        }else{
            let temphour = newHour - 12
            dogSpeech.text = "You will wake up at " + String(format:"%02i:%02i PM", temphour, newMin)
        }
        
    }
   
   
    // Start Button function
    @IBAction func startBtn(_ sender: UIButton) {
        runtimer()
        dogSpeech.text = "ZZZZZ...."
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
            pauseOutlet.backgroundColor = UIColor(hex:"25A55B")
            pauseOutlet.setTitleColor(UIColor(hex:"D0EBB8"), for: .normal)
            self.pauseOutlet.setTitle("Resume",for: .normal)
            dogSpeech.text = "Hey, what's up !"
        } else {
            runtimer()
            self.resumeTapped = false
            pauseOutlet.backgroundColor = UIColor(hex:"147EAF")
            pauseOutlet.setTitleColor(UIColor(hex:"B2DBED"), for: .normal)
            self.pauseOutlet.setTitle("Pause",for: .normal)
            dogSpeech.text = "ZZZZZ...."
        }
    }
    
    
    // cancel Button function
    @IBAction func cancelBtn(_ sender: UIButton) {
        timer.invalidate()
        mins = 30
        seconds = 1800
        sliderOutlet.setValue(30, animated: true)
        timerLabel.text = "30:00"
        dogSpeech.text = "Hi!"
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
        dogSpeech.text = "Hi!"
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
        var snoozeTime = settingsPage.integer(forKey: "Snooze")
        if (snoozeTime == 0){
            snoozeTime = 5
        }
        mins = snoozeTime
        seconds = mins*60
        self.resumeTapped = false
        dogSpeech.text = "ZZZZZ...."
        startOutlet.isHidden = true
        sliderOutlet.isHidden = true
        pauseOutlet.isHidden = false
        cancelOutlet.isHidden = false
        stopAlarmOutlet.isHidden = true
        snoozeOutlet.isHidden = true
        runtimer()
    }
    
    func vibrate(){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    // status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        self.timerLabel.adjustsFontSizeToFitWidth = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        Setting_btn.imageView?.contentMode = .scaleAspectFit
        
        mins = settingsPage.integer(forKey: "Default")
        if (mins == 0){
            mins = 30
        }
        seconds = mins * 60
        timerLabel.text = String(mins) + ":00"
       
        do{
            
            
            if let sound = settingsPage.string(forKey: "Sound"), !sound.isEmpty{
                let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")
                try player = AVAudioPlayer(contentsOf:URL(fileURLWithPath:audioPath!))
            } else {
                let sound = "sound1"
                let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")
                try player = AVAudioPlayer(contentsOf:URL(fileURLWithPath:audioPath!))
            }
        }
        catch{
            //Error
        }
        
        //color setting
        view.backgroundColor = UIColor(hex:"222831")
        timerLabel.textColor = UIColor(hex:"EEEEEE")
        startOutlet.backgroundColor = UIColor(hex:"25A55B")                 //Green
        startOutlet.setTitleColor(UIColor(hex:"D0EBB8"), for: .normal)      //text green
        
        cancelOutlet.backgroundColor = UIColor(hex:"2E3033")                //Grey
        cancelOutlet.setTitleColor(UIColor(hex:"B8B8B8"), for: .normal)
        
        pauseOutlet.backgroundColor = UIColor(hex:"147EAF")
        pauseOutlet.setTitleColor(UIColor(hex:"B2DBED"), for: .normal)
        
        stopAlarmOutlet.backgroundColor = UIColor(hex:"D75A66")             //Red
        stopAlarmOutlet.setTitleColor(UIColor(hex:"FFD1D6"), for: .normal)
        
        snoozeOutlet.backgroundColor = UIColor(hex:"147EAF")                //Blue
        snoozeOutlet.setTitleColor(UIColor(hex:"B2DBED"), for: .normal)
        
        sliderOutlet.tintColor = UIColor(hex:"147EAF")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (startAppBanner == nil) {
            startAppBanner = STABannerView(
                size: STA_PortraitAdSize_320x50,
                autoOrigin: STAAdOrigin_Bottom,
                with: self.view,
                withDelegate: nil);
            self.view.addSubview(startAppBanner!)
        }
    }
}


