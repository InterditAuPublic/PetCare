//
//  AnimalsViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//
import UIKit

class AnimalsViewController: UIViewController, NoAnimalsDelegate {

    let animals : [String] = []
//    let animals = ["test"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        navigationController?.navigationBar.prefersLargeTitles = true

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        addButton.tintColor = .orange
        navigationItem.rightBarButtonItem = addButton
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
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
//            let animalsTableView = UITableView(frame: view.bounds, style: .plain)
//  
//            animalsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//            view.addSubview(animalsTableView)
        }
    }
}

extension AnimalsViewController {
    @objc func didTapAddButton() {
        
        self.navigationController?.pushViewController(AddAnimalViewController(), animated: true)
    }
}

