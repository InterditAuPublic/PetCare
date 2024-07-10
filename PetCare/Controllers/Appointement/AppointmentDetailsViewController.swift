//
//  AppointmentDetailsViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 20/06/2024.
//

import UIKit

class AppointmentDetailsViewController: UIViewController {
        
    // MARK: - Properties
    
    let appointmentDetailsView = AppointmentDetailsView()
    var appointment: Appointment
    
    // MARK: - Initialization
    
    init(appointment: Appointment) {
        self.appointment = appointment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = appointmentDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("appointments", comment: "")
        view.backgroundColor = .white
        appointmentDetailsView.configure(with: appointment)
        navigationItem.largeTitleDisplayMode = .never

        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAppointment))
        navigationItem.rightBarButtonItem = editButton

    }

    // MARK: - Actions

    /// Navigate to the EditAppointmentViewController when the user taps on the edit button
    @objc private func editAppointment() {
        let editAppointmentViewController = EditAppointmentViewController(appointment: appointment)
        navigationController?.pushViewController(editAppointmentViewController, animated: true)
    }
    
}
