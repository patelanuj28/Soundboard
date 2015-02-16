//
//  NewSoundViewController.swift
//  Soundboard
//
//  Created by Anuj Patel on 2/16/15.
//  Copyright (c) 2015 Anuj Patel. All rights reserved.
//
import UIKit
import AVFoundation
import CoreData

class NewSoundViewController : UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        self.audioURL = NSUUID().UUIDString + ".m4a"
        
        var pathComponents = [baseString, self.audioURL]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)!
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        self.audioRecorder = AVAudioRecorder(URL: audioNSURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var soundText: UITextField!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder
    
    var previousViewController = SoundListViewController()
    var audioURL: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Roll Tide...
        
    }
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveButton(sender: AnyObject) {
        //create sound object
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        var sound = NSEntityDescription.insertNewObjectForEntityForName("Sound", inManagedObjectContext: context) as Sound
        sound.name = self.soundText.text
        sound.url = self.audioURL
        
        //add sound to table view
        context.save(nil)
        
        //dismiss this view controller
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func recordButton(sender: AnyObject) {
        
        if audioRecorder.recording {
            self.audioRecorder.stop()
            self.recordButton.setTitle("Record", forState: UIControlState.Normal)
        } else {
            var session = AVAudioSession.sharedInstance()
            session.setActive(true , error: nil)
            self.audioRecorder.record()
            self.recordButton.setTitle("Finish Recording", forState: UIControlState.Normal)
        }

    }
}