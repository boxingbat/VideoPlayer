//
//  VideoView.swift
//  VideoPlayer
//
//  Created by 1 on 2024/1/30.
//


import UIKit
import AVFoundation

class VideoView: UIView {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    private var timeObserverToken: Any?
//    private var controlsView = VideoControlsView()

    weak var controlsDelegate: VideoControlsDelegate?

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }


    func play(with url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player
        player?.play()
        setupTimeObserver()
        player?.currentItem?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
    }

    private func setupTimeObserver() {
        let timeInterval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)) // Define the time interval here.
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: timeInterval, queue: .main) { [weak self] time in
            // Make sure that the player's current item is loaded before trying to access its properties
            guard let currentItem = self?.player?.currentItem else { return }

            // Only proceed if the current item's duration is known
            if currentItem.status == .readyToPlay {
                let currentTime = CMTimeGetSeconds(time)
                let duration = CMTimeGetSeconds(currentItem.duration)

                let currentTimeString = self?.formatTimeFor(seconds: currentTime)
                let durationString = self?.formatTimeFor(seconds: duration)

                // Update the controls using the main thread
                DispatchQueue.main.async {
                    self?.controlsDelegate?.updateTimeSlider(maximumValue: Float(duration), currentTimeValue: Float(currentTime))
                    self?.controlsDelegate?.updateCurrentTimeLabel(time: currentTimeString ?? "00:00")
                    self?.controlsDelegate?.updateDurationLabel(time: durationString ?? "00:00")
                }
            }
        }
    }

    private func formatTimeFor(seconds: Double) -> String {
        let secs = Int(seconds)
        let mins = secs / 60
        let remainingSecs = secs % 60
        return String(format: "%02d:%02d", mins, remainingSecs)
    }



    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status", let playerItem = object as? AVPlayerItem {
            if playerItem.status == .readyToPlay {
                // The video is ready to play. Update the slider's maximum value and current value
                let duration = CMTimeGetSeconds(playerItem.duration)
                DispatchQueue.main.async {
                    self.controlsDelegate?.updateTimeSlider(maximumValue: Float(duration), currentTimeValue: 0)
                }
            }
        }
    }

    deinit {
        // It is safer to remove the observer by specifying the context and the property name.
        player?.currentItem?.removeObserver(self, forKeyPath: "status")
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }

}
