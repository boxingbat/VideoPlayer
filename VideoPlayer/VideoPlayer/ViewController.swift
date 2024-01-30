//
//  ViewController.swift
//  VideoPlayer
//
//  Created by 1 on 2024/1/30.
//

import UIKit

class ViewController: UIViewController {

    let videoView = VideoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupVideoView()
        if let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
            videoView.play(with: url)
        }
    }

    func setupVideoView() {
        view.addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        videoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 16/9).isActive = true
        videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }

    



}

