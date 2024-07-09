//
//  AppointmentsViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class AppointmentsViewController: UIViewController, NoAppointmentDelegate {
    
    var tableView: UITableView!
    var appointments: [Appointment] = []
    var noAppoitmentView: NoAppointmentView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchAppointments()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddAppointment))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupViews() {
        // Initialize UITableView
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: "AppointmentCell")
        tableView.backgroundColor = .white
        
        // Add as subview and setup constraints
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchAppointments() {
        if let fetchedAppointments = CoreDataManager.shared.fetchAppointmentsSortedByDate() {
            appointments = fetchedAppointments
        }
    }
    
    private func updateUI() {
        if appointments.isEmpty {
            showNoAppoitmentView()
        } else {
            tableView.isHidden = false
            tableView.reloadData()
            noAppoitmentView?.removeFromSuperview()
            noAppoitmentView = nil
        }
    }
    
    private func showNoAppoitmentView() {
        tableView.isHidden = true
        if noAppoitmentView == nil {
            noAppoitmentView = NoAppointmentView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            noAppoitmentView?.center = view.center
            noAppoitmentView?.delegate = self
            view.addSubview(noAppoitmentView!)
        }
    }
    
    @objc internal func didTapAddAppointment() {
        navigationController?.pushViewController(AddAppointmentViewController(), animated: true)
    }
    
}

// MARK: UITableViewDataSource
extension AppointmentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentTableViewCell
        let appointment = appointments[indexPath.row]
        cell.configure(with: appointment)
        return cell
    }
    
    // Enable swipe to delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Show alert to confirm deletion
            let alert = UIAlertController(title: NSLocalizedString("delete_appointment_title", comment: ""), message: NSLocalizedString("delete_appointment_message", comment: ""), preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { (action) in
                let appointment = self.appointments[indexPath.row]
                CoreDataManager.shared.deleteAppointment(appointment: appointment)
                self.appointments.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.updateUI()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: UITableViewDelegate
extension AppointmentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAppointment = appointments[indexPath.row]
        let detailsVC = AppointmentDetailsViewController(appointment: selectedAppointment)
        detailsVC.appointment = selectedAppointment
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
