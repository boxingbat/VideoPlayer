//
//  MBConfiguration.swift
//  VideoPlayer
//
//  Created by 1 on 2024/2/2.
//

import Foundation

/// MBConfiguration: it controls player configuration .

protocol Configuration {
    var canShowVideoList: Bool { get }
    var canShowTime: Bool { get }
    var canShowPlayPause: Bool { get }
    var canShowTimeBar: Bool { get }
    var canShowFullScreenBtn: Bool { get }
    var canShowForwardBack: Bool { get }
    var canShowHeader: Bool { get }
    var canShowHeaderTitle: Bool { get }
    var canShowHeaderOption: Bool { get }
    var isShowOverlay: Bool { get set }
    var dimension: PlayerDimension { get }
    var seekDuration: Float64 { get }
}

struct MainConfiguration: Configuration {
    public var canShowVideoList = true
    public var canShowTime = true
    public var canShowPlayPause = true
    public var canShowTimeBar = true
    public var canShowFullScreenBtn = true
    public var canShowForwardBack = true
    public var canShowHeader = true
    public var canShowHeaderTitle = true
    public var canShowHeaderOption = true
    public var isShowOverlay: Bool = true
    public var dimension: PlayerDimension = .embed
    public var seekDuration: Float64 = 15.0
}

