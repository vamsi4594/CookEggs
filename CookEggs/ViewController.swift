//
//  ViewController.swift
//  CookEggs
//
//  Created by 123 on 22/09/20.
//  Copyright © 2020 vamsiOSDev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    let boilTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func clickOnEggs(_ sender: UIButton)
    {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        if let hardness = sender.currentTitle {
            infoLabel.text = "Choosen level is: \(hardness)"
            totalTime = boilTimes[hardness]!
            timeLabel.text = String(totalTime)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func updateTimer() {
        if secondsPassed <= totalTime {
            timeLabel.text = String(totalTime - secondsPassed)
            
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            secondsPassed += 1
        } else {
            timer.invalidate()
            infoLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { print("failed")
            return }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

