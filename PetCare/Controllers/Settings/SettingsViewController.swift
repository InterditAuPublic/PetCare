//
//  SettingsViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func showAbout() {
        //        let aboutViewController = AboutViewController()
        //        navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    private func showHelp() {
        //        let helpViewController = HelpViewController()
        //        navigationController?.pushViewController(helpViewController, animated: true)
    }
    
    private func showTerms() {
        //        let termsViewController = TermsViewController()
        //        navigationController?.pushViewController(termsViewController, animated: true)
    }
    
    private func showPrivacy() {
        //        let privacyViewController = PrivacyViewController()
        //        navigationController?.pushViewController(privacyViewController, animated: true)
    }
    
}
