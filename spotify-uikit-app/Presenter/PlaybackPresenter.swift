//
//  PlaybackPresenter.swift
//  spotify-uikit-app
//
//  Created by loratech on 17/03/24.
//

import Foundation
import UIKit

final class PlaybackPresenter {
    static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let playerVC = PlayerViewController()
        playerVC.title = track.name
        viewController.present(UINavigationController(rootViewController: playerVC), animated: true, completion: nil)
    }

    static func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        let playerVC = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: playerVC), animated: true, completion: nil)
    }

}
