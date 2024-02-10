//
//  PlayerOtem.swift
//  VideoPlayer
//
//  Created by 1 on 2024/2/2.
//

import Foundation

/// data model for video playlist item

public struct PlayerItem {
    let title: String
    let url: String
    let thumbnail: String

    public init(title:String, url: String, thumbnail: String) {
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
    }
}
