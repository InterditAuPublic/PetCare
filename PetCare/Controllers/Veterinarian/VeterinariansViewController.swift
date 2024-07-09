//
//  VeterinariansViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class VeterinariansViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NoVeterinarianDelegate {    
    
    var veterinarians: [Veterinarian] = []
    var veterinariansTableView: UITableView!
    var noVeterinarianView: NoVeterinarianView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchVeterinarians()
        updateUI()
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        veterinariansTableView = UITableView(frame: view.bounds, style: .plain)
        veterinariansTableView.register(VeterinarianTableViewCell.self, forCellReuseIdentifier: VeterinarianTableViewCell.reuseIdentifier)
        veterinariansTableView.delegate = self
        veterinariansTableView.dataSource = self
        view.addSubview(veterinariansTableView)
    }
    
    private func fetchVeterinarians() {
        veterinarians = CoreDataManager.shared.fetchVeterinarians() ?? []
    }
    
    private func updateUI() {
        
        if veterinarians.isEmpty {
            showNoVeterinariansView()
        } else {
            veterinariansTableView.isHidden = false
            veterinariansTableView.reloadData()
            noVeterinarianView?.removeFromSuperview()
            noVeterinarianView = nil
        }
    }
    
    private func showNoVeterinariansView() {
        veterinariansTableView.isHidden = true
        if noVeterinarianView == nil {
            noVeterinarianView = NoVeterinarianView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            noVeterinarianView?.center = view.center
            noVeterinarianView?.delegate = self
            view.addSubview(noVeterinarianView!)
        }
    }
    
    @objc internal func didTapAddButton() {
        navigationController?.pushViewController(AddVeterinarianViewController(), animated: true)
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return veterinarians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VeterinarianTableViewCell.reuseIdentifier, for: indexPath) as! VeterinarianTableViewCell
        let veterinarian = veterinarians[indexPath.row]
        cell.configure(with: veterinarian)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let veterinarian = veterinarians[indexPath.row]
        var actions: [UIContextualAction] = []
        
        let deleteAction = UIContextualAction(style: .destructive, title:  NSLocalizedString("delete", comment: "")) { (action, view, completionHandler) in
                // show alert to confirm deletion of veterinarian, if it have appointments show a warning 
            let alert = UIAlertController(title: NSLocalizedString("delete_veterinarian_title", comment: ""), message: NSLocalizedString("delete_veterinarian_message", comment: ""), preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { (action) in
                CoreDataManager.shared.deleteVeterinarian(veterinarian: veterinarian)
                self.veterinarians.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.updateUI()
            }))

            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
    
        }
        actions.append(deleteAction)
        
        if let phoneNumber = veterinarian.phone, !phoneNumber.isEmpty {
            let callAction = UIContextualAction(style: .normal, title: NSLocalizedString("call", comment: "")) { (action, view, completionHandler) in
                if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                    UIApplication.shared.open(phoneURL)
                }
                completionHandler(true)
            }
            callAction.backgroundColor = .systemGreen
            actions.append(callAction)
        }
        
        if let email = veterinarian.email, !email.isEmpty {
            let emailAction = UIContextualAction(style: .normal, title: NSLocalizedString("email", comment: "")) { (action, view, completionHandler) in
                if let emailURL = URL(string: "mailto:\(email)") {
                    UIApplication.shared.open(emailURL)
                }
                completionHandler(true)
            }
            emailAction.backgroundColor = .systemBlue
            actions.append(emailAction)
        }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVeterinarian = veterinarians[indexPath.row]
        
        let veterinarianDetailViewController = VeterinarianDetailViewController(veterinarian: selectedVeterinarian)
        veterinarianDetailViewController.veterinarian = selectedVeterinarian
        navigationController?.pushViewController(veterinarianDetailViewController, animated: true)
    }
}

