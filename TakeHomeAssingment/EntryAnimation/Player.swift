//
//  Player.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 29/01/2021.
//

import UIKit
import AVFoundation

class Player {

    static let sharedInstance = Player()

    var audioPlayer: AVAudioPlayer?

    func playSound(name: String, extension: String = "wav") {
        let sound = Bundle.main.url(forResource: name, withExtension: `extension`)

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            UIApplication.shared.beginReceivingRemoteControlEvents()

            audioPlayer = try AVAudioPlayer(contentsOf: sound!)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }

}
