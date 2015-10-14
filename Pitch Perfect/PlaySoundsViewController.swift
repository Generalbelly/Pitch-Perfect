//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by ShimmenNobuyoshi on 2015/03/06.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var audioFile: RecordedAudio!
    var engine: AVAudioEngine!
    var avAudioFile: AVAudioFile!
    var playerNode: AVAudioPlayerNode!

    @IBAction func snaleButtonTouched(sender: UIButton) {
    
        playAudioAtAnyRate(0.5)

    }

    @IBAction func rabbitButtonTouched(sender: UIButton) {

        playAudioAtAnyRate(2.0)

    }

    @IBAction func chipmunkButtonTouched(sender: UIButton) {

        plyaAudioWithVariablePitch(1000)

    }

    @IBAction func darthVaderButtonTouched(sender: UIButton) {

        plyaAudioWithVariablePitch(-1000)

    }

    func playAudioAtAnyRate(rate: Float) {

        stopPlayerAndEngine()

        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()

    }

    func stopPlayerAndEngine() {

        audioPlayer.stop()
        engine.stop()
        engine.reset()

    }


    func plyaAudioWithVariablePitch(pitch: Float){

        stopPlayerAndEngine()

        playerNode = AVAudioPlayerNode()
        engine.attachNode(playerNode)

        let auTimePitch = AVAudioUnitTimePitch()
        auTimePitch.pitch = pitch
        engine.attachNode(auTimePitch)

        engine.connect(playerNode, to: auTimePitch, format: nil)
        engine.connect(auTimePitch, to: engine.outputNode, format: nil)

        playerNode.scheduleFile(avAudioFile, atTime: nil, completionHandler: nil)
        do {
            try engine.start()
        } catch _ {
        }
        playerNode.play()

    }

    @IBAction func stopButtonTouched(sender: UIButton) {

        audioPlayer.stop()
        playerNode.stop()

    }
    

    override func viewDidLoad() {

        super.viewDidLoad()
        audioPlayer = try? AVAudioPlayer(contentsOfURL: audioFile.filePathUrl)
        audioPlayer.enableRate = true
        avAudioFile = try? AVAudioFile(forReading: audioFile.filePathUrl)
        engine = AVAudioEngine()

    }

}
