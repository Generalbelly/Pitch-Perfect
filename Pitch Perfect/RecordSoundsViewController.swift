//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by ShimmenNobuyoshi on 2015/03/05.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import  UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder?
    var recordedAudio: RecordedAudio!
    @IBOutlet weak var recording: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    @IBAction func recordButtonTouched(sender: UIButton) {

        recording.text = "recording"
        stopButton.hidden = false
        recordButton.enabled = false

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyymmdd-hhmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }

        do {
            audioRecorder = try AVAudioRecorder(URL: filePath!, settings: [:])
        } catch _ {
        }
        audioRecorder!.delegate = self
        audioRecorder!.meteringEnabled = true
        audioRecorder!.prepareToRecord()
        audioRecorder!.record()

    }

    @IBAction func stopButtonTouched(sender: UIButton) {

        audioRecorder!.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
        }

    }

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {

        recording.text = "Tap to record"
        stopButton.hidden = true
        recordButton.enabled = true

    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {

        if flag {

            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("segueToPlaySounds", sender: recordedAudio)

        } else {

            stopButton.hidden = true
            recordButton.enabled = true
        }

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToPlaySounds" {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.audioFile = data
        }
    }

}

