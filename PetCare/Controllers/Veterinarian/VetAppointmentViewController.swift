//
//  VetAppointmentViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class VetAppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var veterinarians: [Veterinarian] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchVeterinarians()
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddVetButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func fetchVeterinarians() {
        if let fetchedVeterinarians = CoreDataManager.shared.fetchVeterinarians() {
            veterinarians = fetchedVeterinarians
            print(veterinarians)
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            if self.veterinarians.isEmpty {
                // Display the NoAnimalView
                let noAnimalView = NoAnimalView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                noAnimalView.center = self.view.center
           
                
                // Remove any existing table view
                self.view.subviews.forEach { $0.removeFromSuperview() }
                
                // Add the NoAnimalView
                self.view.addSubview(noAnimalView)
            } else {
                // Display the UITableView
                let animalsTableView = UITableView(frame: self.view.bounds, style: .plain)
                animalsTableView.register(VeterinarianTableViewCell.self, forCellReuseIdentifier: "veterinarianCell")
                animalsTableView.delegate = self
                animalsTableView.dataSource = self
                
                // Remove any existing NoAnimalView
                self.view.subviews.forEach { subview in
                    if subview is NoAnimalView {
                        subview.removeFromSuperview()
                    }
                }
                
                // Add the UITableView
                self.view.addSubview(animalsTableView)
            }
        }
    }
    
    // MARK: - Navigation
    
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return veterinarians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "veterinarianCell", for: indexPath) as! VeterinarianTableViewCell
        let veterinarian = veterinarians[indexPath.row]
        cell.configure(with: veterinarian)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let animalToDelete = veterinarians[indexPath.row]
            CoreDataManager.shared.deleteVeterinarian(veterinarian: animalToDelete)
            fetchVeterinarians()
            updateUI()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedAnimal = veterinarians[indexPath.row]
            
        }
    

}


extension VetAppointmentViewController {
    @objc func didTapAddVetButton() {
        self.navigationController?.pushViewController(AddVetViewController(), animated: true)
    }
}

