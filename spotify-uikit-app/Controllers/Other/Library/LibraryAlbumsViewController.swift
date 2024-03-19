//
//  LibraryAlbumsViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 18/03/24.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {

    
    var albums = [Album]()

    private let noAlbumsView = ActionLabelView()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = false

        return tableView
    }()

    private var observer: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setupNoAlbumsViewView()
        fetchData()

        observer = NotificationCenter.default.addObserver(forName: .albumSavedNotification, object: nil, queue: .main, using: { [weak self] _ in
            self?.fetchData()
        })
    }

    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumsView.frame = CGRect(x: (view.width-150)/2, y: (view.width-150)/2, width: 150, height: 150)
        tableView.frame = view.bounds
    }

    private func fetchData() {
        albums.removeAll()
        NetworkManager.shared.getCurrentUserAlbums { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                    case .success(let albums): 
                        self.albums = albums
                        self.updateUI()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }

        }
    }

    private func setupNoAlbumsViewView() {
        view.addSubview(noAlbumsView)
        noAlbumsView.delegate = self
        noAlbumsView.configure(with: ActionLabelViewViewModel(text: "You don't save any albums yet.", actionTitle: "Browse"))
    }

    private func updateUI() {
        if albums.isEmpty {
            noAlbumsView.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.reloadData()
            tableView.isHidden = false
            noAlbumsView.isHidden = true
        }
    }

    public func showCreatePlaylistAlert() {
        // MARK:  Show ui creation of playlist
        let alert = UIAlertController(title: "New Playlists", message: "Enter playlist name.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlists..."
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            NetworkManager.shared.createPlaylist(with: text) { [weak self] success in
                guard let self = self else { return }
                if success {
                    self.fetchData()
                } else {
                    print("Failed to create playlists.")
                }
            }

        }))

        present(alert, animated: true)
    }
}


extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }

        let album = albums[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: album.name, subtitle: album.artists.first?.name ?? "", imageURL: URL(string: album.images.first?.url ?? "")))

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let album = albums[indexPath.row]

        let playlistVC = AlbumViewController(album: album)
        playlistVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(playlistVC, animated: true)
    }


}
