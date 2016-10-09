//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Invision on 06/10/2016.
//  Copyright © 2016 Invision. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController ,AVAudioRecorderDelegate{

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

    @IBAction func recordAudio(sender: AnyObject) {
        
        recordingLabel.text = "Recording in Action"
        stopRecordingButton.enabled = true
        recordButton.enabled = false
       let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        
             //        CREATE AUDIO SESSION
         let session = AVAudioSession.sharedInstance()
         try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
         try! audioRecorder = AVAudioRecorder(URL:filePath!,settings:[:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

        
        
    }
    
    
    
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    
    }
    
    
    func audioRecorderDidFinishRecording(recorder:AVAudioRecorder,sucessfully flag : Bool){
        if(flag){
            self.performSegueWithIdentifier("stopRecording",sender:audioRecorder.url)
        }
        else{
            print("Recording has Failed")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
        let playSoundsVC = segue.destinationViewController as!
            PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudio = recordedAudioURL
        }
    }
}

