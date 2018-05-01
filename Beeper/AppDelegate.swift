//
//  AppDelegate.swift
//  Beeper
//
//  Created by Tom Brek on 01/05/2018.
//  Copyright © 2018 Tom Brek. All rights reserved.
//

import Cocoa
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var beepButton: NSButton!
    @IBOutlet weak var silenceButton: NSButton!
    @IBOutlet weak var whitenoiseButton: NSButton!
    
    @IBOutlet weak var timeSlider: NSSlider!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var startstopButton: NSButton!
    var timer = Timer()
    var interval: Double!
    var mp3Player: AVAudioPlayer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func beepButtonDown(_ sender: Any) {
        beepButton.state = .on
        silenceButton.state = .off
        whitenoiseButton.state = .off
        timeLabel.stringValue = timeSlider.stringValue
        timeSlider.isEnabled = true
    }
    
    @IBAction func silenceButtonDown(_ sender: Any) {
        beepButton.state = .off
        silenceButton.state = .on
        whitenoiseButton.state = .off
        timeLabel.stringValue = timeSlider.stringValue
        timeSlider.isEnabled = true
        
    }
    
    @IBAction func whitenoiseButtonDown(_ sender: Any) {
        beepButton.state = .off
        silenceButton.state = .off
        whitenoiseButton.state = .on
        timeLabel.stringValue = "∞"
        timeSlider.isEnabled = false
    }
    
    
    @IBAction func startstopButtonDown(_ sender: Any) {
        if startstopButton.title == "Start" {
            startstopButton.title = "Stop"
            timeSlider.isEnabled = false
            startTimer()
        }
        else {
            startstopButton.title = "Start"
            timeSlider.isEnabled = true
            stopTimer()
        }
    }
    
    @IBAction func sliderAdjusted(_ sender: Any) {
        timeLabel.stringValue = timeSlider.stringValue
    }
    
    func startTimer() {
        silenceButton.isEnabled = false
        whitenoiseButton.isEnabled = false
        beepButton.isEnabled = false
        if whitenoiseButton.state == .on {
            playSomething()
        }
        else {
        interval = Double(timeSlider.stringValue)
        timer = Timer.scheduledTimer(timeInterval: interval! * 60, target: self, selector: #selector(self.playSomething), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        silenceButton.isEnabled = true
        whitenoiseButton.isEnabled = true
        beepButton.isEnabled = true
        timer.invalidate()
        mp3Player?.stop()
    }
    
    @objc func playSomething() {
        if beepButton.state == .on {
            NSSound(named: NSSound.Name(rawValue: "beep.mp3"))?.play()
        }
        if silenceButton.state == .on {
            NSSound(named: NSSound.Name(rawValue: "silence.mp3"))?.play()
        }
        if whitenoiseButton.state == .on {
            let path = Bundle.main.path(forResource: "whitenoise", ofType:"mp3")!
            let url = URL(fileURLWithPath: path)
            do {
                mp3Player = try AVAudioPlayer(contentsOf: url)
                try AVAudioPlayer(contentsOf: url).play()
                mp3Player?.numberOfLoops = -1
                mp3Player?.play()
                
            } catch {
                // bla bla blah
            }
            

        }
    }
}

