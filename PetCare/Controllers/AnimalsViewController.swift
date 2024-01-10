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
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        view.subviews.forEach { $0.removeFromSuperview() }
        
        if animals.isEmpty {
            let noAnimalView = NoAnimalView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            noAnimalView.center = view.center
            noAnimalView.delegate = self
            view.addSubview(noAnimalView)
        } else {
            // Display the list of animals
            let animalsTableView = UITableView(frame: view.bounds, style: .plain)
            animalsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            animalsTableView.delegate = self
            animalsTableView.dataSource = self
            view.addSubview(animalsTableView)
        }
    }
}

extension AnimalsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let animal = animals[indexPath.row]
        cell.textLabel?.text = animal.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let animalToDelete = animals[indexPath.row]
            CoreDataManager.shared.deleteAnimal(animal: animalToDelete)
            fetchAnimals() // Refresh the data after deletion
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension AnimalsViewController {
    @objc func didTapAddButton() {
        
        self.navigationController?.pushViewController(AddAnimalViewController(), animated: true)
    }
}

