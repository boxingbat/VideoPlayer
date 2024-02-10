//
//  VideoControlsView.swift
//  VideoPlayer
//
//  Created by 1 on 2024/1/30.
//

import UIKit

protocol VideoControlsDelegate: AnyObject {
    func didTogglePlayPause()
    func didChangeTimeSliderValue(_ value: Float)
    func updateTimeSlider(maximumValue: Float, currentTimeValue: Float)
    func updateCurrentTimeLabel(time: String)
    func updateDurationLabel(time: String)
}

class VideoControlsView: UIView {

    let playPauseButton = UIButton(type: .system)
    let timeSlider = UISlider()
    let currentTimeLabel = UILabel()
    let durationLabel = UILabel()

    weak var delegate: VideoControlsDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        // Play/Pause Button
        playPauseButton.setTitle("Play", for: .normal)
        playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        timeSlider.isContinuous = true

        // Time Slider
        timeSlider.minimumValue = 0
        timeSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

        // Current Time Label
        currentTimeLabel.text = "00:00"
        currentTimeLabel.textAlignment = .right

        // Duration Label
        durationLabel.text = "00:00"
        durationLabel.textAlignment = .left

        // Layout
        addSubviews(playPauseButton, timeSlider, currentTimeLabel, durationLabel)
        setupConstraints()
    }

    private func setupConstraints() {
            playPauseButton.translatesAutoresizingMaskIntoConstraints = false
            timeSlider.translatesAutoresizingMaskIntoConstraints = false
            currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            durationLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                // Play/Pause Button - Center it horizontally and vertically
                playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                playPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                playPauseButton.widthAnchor.constraint(equalToConstant: 50),
                playPauseButton.heightAnchor.constraint(equalToConstant: 50),

                // Time Slider - Position it at the certain distance from the Play/Pause button
                timeSlider.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 8),
                timeSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                timeSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor),

                // Current Time Label - Position it at the bottom left
                currentTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
                currentTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
                currentTimeLabel.widthAnchor.constraint(equalToConstant: 50),

                // Duration Label - Position it at the bottom right
                durationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
                durationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
                durationLabel.widthAnchor.constraint(equalToConstant: 50)
            ])
        }

    @objc private func togglePlayPause() {
        delegate?.didTogglePlayPause()
    }

    @objc private func sliderValueChanged() {
        delegate?.didChangeTimeSliderValue(timeSlider.value)
    }

    private func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    func updatePlayPauseButton(isPlaying: Bool) {
        playPauseButton.setTitle(isPlaying ? "Pause" : "Play", for: .normal)
    }

    func updateTimeSlider(maximumValue: Float, currentTimeValue: Float) {
        timeSlider.maximumValue = maximumValue
        timeSlider.value = currentTimeValue
    }

    func updateCurrentTimeLabel(time: String) {
        currentTimeLabel.text = time
    }

    func updateDurationLabel(time: String) {
        durationLabel.text = time
    }
}
