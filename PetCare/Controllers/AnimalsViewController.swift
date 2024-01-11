//
//  AnimalsViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//
import UIKit

class AnimalsViewController: UIViewController, NoAnimalsDelegate {
    
    var animals : [Animal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        addButton.tintColor = .orange
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAnimals()
        updateUI()
    }
    
    private func fetchAnimals() {
        if let fetchedAnimals = CoreDataManager.shared.fetchAnimals() {
            animals = fetchedAnimals
            print(animals)
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            if self.animals.isEmpty {
                // Display the NoAnimalView
                let noAnimalView = NoAnimalView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                noAnimalView.center = self.view.center
                noAnimalView.delegate = self
                
                // Remove any existing table view
                self.view.subviews.forEach { $0.removeFromSuperview() }
                
                // Add the NoAnimalView
                self.view.addSubview(noAnimalView)
            } else {
                // Display the UITableView
                let animalsTableView = UITableView(frame: self.view.bounds, style: .plain)
                animalsTableView.register(AnimalTableViewCell.self, forCellReuseIdentifier: "animalCell")
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
}

extension AnimalsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath) as! AnimalTableViewCell
        let animal = animals[indexPath.row]
        cell.configure(with: animal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let animalToDelete = animals[indexPath.row]
            CoreDataManager.shared.deleteAnimal(animal: animalToDelete)
            fetchAnimals() // Refresh the data after deletion
            updateUI()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedAnimal = animals[indexPath.row]
            
        // Create an instance of AnimalDetailViewController
                let animalDetailViewController = AnimalDetailViewController(selectedAnimal: selectedAnimal)        

            // Push the detail view controller onto the navigation stack
            navigationController?.pushViewController(animalDetailViewController, animated: true)
        }
}


extension AnimalsViewController {
    @objc func didTapAddButton() {
        
        self.navigationController?.pushViewController(AddAnimalViewController(), animated: true)
    }
}

