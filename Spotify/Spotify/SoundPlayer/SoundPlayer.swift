//
//  SoundPlayer.swift
//  Spotify
//
//  Created by Melik Demiray on 23.01.2025.
//

import Foundation
import AVFoundation

protocol SoundPlayerProtocol {
    func play(url: URL)
    func pause()
    func resume()
    func stop()
    var isPlaying: Bool { get }
    var currentPlayingURL: URL? { get }
}

final class SoundPlayer: NSObject, SoundPlayerProtocol {
    
    // MARK: - Properties
    static let shared = SoundPlayer()
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private(set) var currentPlayingURL: URL?
    
    private override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Public Methods
    func play(url: URL) {
        // If the same URL is already playing, just resume
        if url == currentPlayingURL {
            resume()
            return
        }
        
        // Stop any existing playback
        stop()
        
        // Store current URL
        currentPlayingURL = url
        
        // Create new AVPlayerItem and AVPlayer
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        // Add observer for player status
        playerItem?.addObserver(self, 
                              forKeyPath: #keyPath(AVPlayerItem.status),
                              options: [.old, .new],
                              context: nil)
        
        // Start playback
        player?.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                             of object: Any?,
                             change: [NSKeyValueChangeKey : Any]?,
                             context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            switch status {
            case .readyToPlay:
                print("Ready to play")
            case .failed:
                if let error = playerItem?.error {
                    print("Failed to play streaming audio: \(error.localizedDescription)")
                }
            case .unknown:
                print("Unknown playback status")
            @unknown default:
                break
            }
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func resume() {
        player?.play()
    }
    
    func stop() {
        player?.pause()
        
        if let playerItem = playerItem {
            playerItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        }
        
        playerItem = nil
        player = nil
    }
    
    var isPlaying: Bool {
        return player?.timeControlStatus == .playing
    }
    
    deinit {
        stop()
    }
}
