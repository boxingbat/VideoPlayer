//
//  ViewController.swift
//  VideoPlayer
//
//  Created by 1 on 2024/1/30.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, VideoControlsDelegate {

    let videoView = VideoView()
    let videoController = VideoControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoView()
        videoController.isUserInteractionEnabled = true
        videoView.isUserInteractionEnabled = true
        if let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
            videoView.play(with: url)
        }
    }

    func setupVideoView() {

        videoController.delegate = self

        view.addSubview(videoView)
        view.addSubview(videoController)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoController.translatesAutoresizingMaskIntoConstraints = false

        // VideoView constraints
        NSLayoutConstraint.activate([
            videoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            videoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 16/9),
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // VideoController constraints
        NSLayoutConstraint.activate([
            videoController.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: -150),
            videoController.leadingAnchor.constraint(equalTo: videoView.leadingAnchor),
            videoController.trailingAnchor.constraint(equalTo: videoView.trailingAnchor),
            // Assuming you want the controls view to have a specific height, for example 50
            videoController.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func didTogglePlayPause() {
        if videoView.player?.timeControlStatus == .playing {
            videoView.player?.pause()
        } else {
            videoView.player?.play()
        }
        videoController.updatePlayPauseButton(isPlaying: videoView.player?.timeControlStatus == .playing)
    }

    func didChangeTimeSliderValue(_ value: Float) {
        guard let player = videoView.player else { return }
        guard let duration = player.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = totalSeconds * Double(value)
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: Int32(NSEC_PER_SEC))
        player.seek(to: seekTime)
    }
    func updateTimeSlider(maximumValue: Float, currentTimeValue: Float) {
        videoController.updateTimeSlider(maximumValue: maximumValue, currentTimeValue: currentTimeValue)
    }

    func updateCurrentTimeLabel(time: String) {
        videoController.updateCurrentTimeLabel(time: time)
    }

    func updateDurationLabel(time: String) {
        videoController.updateDurationLabel(time: time)
    }
}

