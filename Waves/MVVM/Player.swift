//
//  Player.swift
//  Waves
//
//  Created by David Fanaro on 11/2/20.
//

import Foundation
import AVFoundation
import MediaPlayer

class Player: ObservableObject {
    
    var mediaPlayer: AVPlayer?
    
    var playingQueue:DispatchQueue?
    
    @Published var song:Song?
    @Published var isPlaying = false
    
    
    init() {
        playingQueue = DispatchQueue(label: "playing")
        do {
            try AVAudioSession.sharedInstance()
                .setCategory(AVAudioSession.Category.playback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        //setupMediaPlayer()
    }
    
    func loadSong(song:Song){
        isPlaying = false
        self.song = song
        self.mediaPlayer?.pause()
        self.mediaPlayer = nil
        
        guard let url = URL(string: self.song!.url) else{
            return
        }
        self.mediaPlayer = AVPlayer(url: url)
        print(song)
    }
    
    @objc func play(){
        
        playingQueue?.async {
            self.mediaPlayer?.play()
            
        }
        self.isPlaying = true
    }
    
    @objc func pause() {
        
        playingQueue?.async {
            self.mediaPlayer?.pause()
            
        }
        self.isPlaying = false
        
        
    }
    
    
    @objc func setupMediaPlayer()  {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(play))
        commandCenter.pauseCommand.addTarget(self, action: #selector(pause))
    }
    
    
}
