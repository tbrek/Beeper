//
//  AppDelegate.swift
//  Beeper
//
//  Created by Tom Brek on 01/05/2018.
//  Copyright © 2018 Tom Brek. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var beepButton: NSButton!
    @IBOutlet weak var silenceButton: NSButton!
    @IBOutlet weak var timeSlider: NSSlider!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var startstopButton: NSButton!
    var timer = Timer()
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func beepButtonDown(_ sender: Any) {
        beepButton.state = .on
        silenceButton.state = .off
    }
    
    @IBAction func silenceButtonDown(_ sender: Any) {
        beepButton.state = .off
        silenceButton.state = .on
        
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
        let interval = Double(timeSlider.stringValue)
        timer = Timer.scheduledTimer(timeInterval: interval! * 60, target: self, selector: #selector(self.playSomething), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc func playSomething() {
        if beepButton.state == .on {
            NSSound(named: NSSound.Name(rawValue: "beep.mp3"))?.play()
        }
        else {
            NSSound(named: NSSound.Name(rawValue: "silence.mp3"))?.play()
        }
    }
    
    
    
}

