//
//  ProfileViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var models: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        fetchProfile()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func fetchProfile() {
            NetworkManager.shared.getCurrentProfile { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let model):
                        self.updateUI(with: model)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                        self.failedToGetProfile()
                    }
                }

            }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Full Name: \(model.displayName)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        
        tableView.reloadData()
    }
    
    private func failedToGetProfile() {
        let label = UILabel()
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
        
    }
    
    // MARK:  Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
