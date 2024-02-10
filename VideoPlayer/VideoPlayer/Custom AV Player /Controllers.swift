//
//  Controllers.swift
//  VideoPlayer
//
//  Created by 1 on 2024/2/4.
//

import UIKit

/// Controls: This enum keeps images of the constols according to their state.

enum Controls {

    case playpause(Bool)
    case forward
    case back
    case slider
    case resize(PlayerDimension)
    case options

    var image: UIImage? {
        switch self {
        case .playpause(let isActive):
            return UIImage(systemName: isActive ? "pause.fill" : "play.fill" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .heavy, scale: .large))
        case .resize(let dimension):
            switch dimension {
            case .embed:
                return UIImage(systemName: "arrow.down.right.and.arrow.up.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .heavy, scale: .large))
            case .fullScreen:
                return UIImage(systemName: "arrow.up.left.and.arrow.down.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .heavy, scale: .large))
            }
        case .back:
            return UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .heavy, scale: .medium))
        case .forward:
            return UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .heavy, scale: .medium))
        case .options:
            return UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .heavy, scale: .medium))
        default:
            return nil


        }
    }
}
