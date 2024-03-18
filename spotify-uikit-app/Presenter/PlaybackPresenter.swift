//
//  PlaybackPresenter.swift
//  spotify-uikit-app
//
//  Created by loratech on 17/03/24.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()

    private var track: AudioTrack?

    private var tracks = [AudioTrack]()

    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    var playerViewController: PlayerViewController?
    var index = 0

    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.playerQueue,!tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }





    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        guard let url = URL(string: track.previewUrl ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.0
        player?.play()

        self.track = track
        self.tracks = []
        let playerVC = PlayerViewController()
        playerVC.title = track.name
        playerVC.dataSource = self
        playerVC.delegate = self
        viewController.present(UINavigationController(rootViewController: playerVC), animated: true) { [weak self ]  in
            guard let self = self else { return }
            self.player?.play()
        }
        self.playerViewController = playerVC
    }

    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil

        let items: [AVPlayerItem] = tracks.compactMap({
            guard let url = URL(string: $0.previewUrl ?? "") else { return nil}
            return AVPlayerItem(url: url)
        })
        self.playerQueue = AVQueuePlayer(items: items )
        self.playerQueue?.volume = 0
        self.player?.play()

        let playerVC = PlayerViewController()
        playerVC.dataSource = self
        playerVC.delegate = self
        viewController.present(UINavigationController(rootViewController: playerVC), animated: true, completion: nil)
        self.playerViewController = playerVC
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        } else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            // MARK:  Not playlist or album
            player?.pause()
        } else if let player = playerQueue {
            if index == tracks.count-1 {
                player.pause()
            } else {
                player.advanceToNextItem()
                index += 1
                playerViewController?.refreshUI()
            }
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            // MARK:  Not playlist or album
            player?.pause()
        } else if let player = playerQueue {
            if index == 0 {
                player.pause()
            } else {
                index -= 1
                playerViewController?.refreshUI()
            }
        }
    }

    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

