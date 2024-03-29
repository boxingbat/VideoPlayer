//
//  VideoCollectionViewCell.swift
//  VideoPlayer
//
//  Created by 1 on 2024/2/2.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    let videoThumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        return imageView
    }()

    let titleLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textColor = .white
       label.textAlignment = .left
       label.numberOfLines = 1
       return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(videoThumbnail)
        addSubview(titleLabel)

        videoThumbnail.pinEdges(to: self)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 5).isActive = true
    }
    private func applyTheme(_ theme: MBTheme) {
        titleLabel.textColor = theme.playListItemsTextColor
        titleLabel.font = theme.playListItemsFont
    }
    func setData(_ playListItem: PlayerItem?, theme: MBTheme = MainTheme()) {
        guard let playListItem = playListItem else {
            return
        }
        titleLabel.text = playListItem.title
        videoThumbnail.image = UIImage(named: "Video_icon")
        applyTheme(theme)
    }
}

