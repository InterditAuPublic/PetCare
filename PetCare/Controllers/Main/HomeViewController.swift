//
//  HomeViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/02/2024.
//

import UIKit

class HomeViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAppointmentsAndAnimals()
    }
    
    private func fetchAppointmentsAndAnimals() {
        guard let fetchNextAppointments = CoreDataManager.shared.fetchUpcomingAppointmentsSortedByDate(),
              let fetchedAnimals = CoreDataManager.shared.fetchAnimals(),
              let fetchPastAppointments = CoreDataManager.shared.fetchPastAppointmentsSortedByDate() else {
            return
        }
        
        let animals: [Any] = fetchedAnimals.isEmpty ? [NSLocalizedString("no_animals", comment: "")] : fetchedAnimals
        
        let animalsSection = Section.animal(title: NSLocalizedString("my_animals", comment: ""), items: animals)
        
        let nextAppointments: [Any] = fetchNextAppointments.isEmpty ? [NSLocalizedString("no_upcoming_appointments", comment: "")] : fetchNextAppointments
        let pastAppointments: [Any] = fetchPastAppointments.isEmpty ? [NSLocalizedString("no_past_appointments", comment: "")] : fetchPastAppointments
        
        let appointmentsSection = Section.appointment(title: NSLocalizedString("next_appointments", comment: ""), items: nextAppointments)
        let pastAppointmentsSection = Section.appointment(title: NSLocalizedString("prev_appointments", comment: ""), items: pastAppointments)
        
        sections = [animalsSection, appointmentsSection, pastAppointmentsSection]
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.register(AnimalHomeCollectionViewCell.self, forCellWithReuseIdentifier: "AnimalHomeCollectionViewCell")
        collectionView.register(AppointmentCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentCollectionViewCell")
        collectionView.register(NoItemCollectionViewCell.self, forCellWithReuseIdentifier: "NoItemCollectionViewCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .animal:
                return self.createAnimalLayout()
            case .appointment:
                return self.createAppointmentLayout()
            }
        }
    }
    
    private func createAnimalLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(80), heightDimension: .absolute(100)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 10, leading: 15, bottom: 30, trailing: 15)
        section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
        return section
    }
    
    private func createAppointmentLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 10, leading: 15, bottom: 30, trailing: 10)
        section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .animal(_, let items):
            if let message = items[indexPath.row] as? String {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoItemCollectionViewCell", for: indexPath) as! NoItemCollectionViewCell
                cell.setup(message)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalHomeCollectionViewCell", for: indexPath) as! AnimalHomeCollectionViewCell
                cell.setup(items[indexPath.row] as! Animal)
                return cell
            }
        case .appointment(_, let items):
            if let message = items[indexPath.row] as? String {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoItemCollectionViewCell", for: indexPath) as! NoItemCollectionViewCell
                cell.setup(message)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCollectionViewCell", for: indexPath) as! AppointmentCollectionViewCell
                cell.setup(items[indexPath.row] as! Appointment)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        headerView.setup(sections[indexPath.section].title)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .animal(_, let items):
            if let animal = items[indexPath.row] as? Animal {
                let animalDetailVC = AnimalDetailsViewController(animal: animal)
                navigationController?.pushViewController(animalDetailVC, animated: true)
            }
        case .appointment(_, let items):
            if let appointment = items[indexPath.row] as? Appointment {
                let appointmentDetailVC = AppointmentDetailsViewController(appointment: appointment)
                navigationController?.pushViewController(appointmentDetailVC, animated: true)
            }
        }
    }
}

enum Section {
    case animal(title: String, items: [Any])
    case appointment(title: String, items: [Any])
    
    var title: String {
        switch self {
        case .animal(let title, _), .appointment(let title, _):
            return title
        }
    }
    
    var count: Int {
        switch self {
        case .animal(_, let items):
            return items.count
        case .appointment(_, let items):
            return items.count
        }
    }
}
