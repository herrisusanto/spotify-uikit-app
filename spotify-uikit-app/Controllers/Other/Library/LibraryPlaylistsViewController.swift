//
//  LibraryPlaylistsViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 18/03/24.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {

    var playlists = [Playlist]()

    private let noPlaylistsView = ActionLabelView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNoPlaylistsView()
        fetchPlaylist()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
    }

    private func fetchPlaylist() {
        NetworkManager.shared.getCurrentUserPlaylists { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let playlists):
                        self.playlists = playlists
                        self.updateUI()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }

    private func setupNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(with: ActionLabelViewViewModel(text: "You don't have any playlists yet.", actionTitle: "Create"))
    }

    private func updateUI() {
        if playlists.isEmpty {
            // MARK:  Show label
            noPlaylistsView.isHidden = false
        } else {
            // MARK:  Show table
        }
    }
}


extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        // MARK:  Show ui creation of playlist
    }
}
