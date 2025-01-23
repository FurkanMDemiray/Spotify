//
//  MainVM.swift
//  Spotify
//
//  Created by Melik Demiray on 1.01.2025.
//

import Foundation

protocol MainVMProtocol {
    var delegate: MainVMDelegate? { get set }
    func playSound()
    var isPlaying: Bool { get }
}

protocol MainVMDelegate: AnyObject {
    func updatePlayButtonState(isPlaying: Bool)
}

final class MainVM {
    // Use a direct audio file URL that's known to work
    let url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")

    weak var delegate: MainVMDelegate?
    private var soundManager: SoundPlayerProtocol!

    var isPlaying: Bool {
        return soundManager.isPlaying
    }

    init(soundManager: SoundPlayerProtocol) {
        self.soundManager = soundManager
    }
}

extension MainVM: MainVMProtocol {
    func playSound() {
        guard let url = url else {
            print("Invalid audio URL")
            return
        }
        
        if soundManager.currentPlayingURL == url && soundManager.isPlaying {
            soundManager.pause()
        } else {
            soundManager.play(url: url)
        }
        
        delegate?.updatePlayButtonState(isPlaying: soundManager.isPlaying)
    }
}




