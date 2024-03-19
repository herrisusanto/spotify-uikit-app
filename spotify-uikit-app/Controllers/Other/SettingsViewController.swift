//
//  SettingsViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import UIKit

class SettingsViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureModels() {
        sections.append(
            Section(title: "Profile", options: [Option(title: "View Your Profile", handler: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.viewProfile()
                }
            })])
        )
        
        sections.append(
            Section(title: "Account", options: [Option(title: "Sign Out", handler: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.signOutTapped()
                }
            })])
        )
    }
    
    private func viewProfile() {
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        profileViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func signOutTapped() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] success in
                guard let self = self else { return }
                if success {
                    DispatchQueue.main.async {
                        let navigationVC = UINavigationController(rootViewController: WelcomeViewController())
                        navigationVC.navigationBar.prefersLargeTitles = true
                        navigationVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
                        navigationVC.modalPresentationStyle = .fullScreen
                        self.present(navigationVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                        }
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // MARK:  Call handle for cell
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
 
