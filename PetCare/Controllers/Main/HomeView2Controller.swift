//
//  HomeView2Controller.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/02/2024.
//

import UIKit

class HomeView2Controller: UIViewController {
    private var collectionView: UICollectionView!
    private var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAppointmentsAndAnimals()

    }
    
    private func fetchAppointmentsAndAnimals() {
        guard let fetchedAppointments = CoreDataManager.shared.fetchUpcomingAppointementsSortedByDate() else {
            print("Failed to fetch appointments")
            return
        }
        guard let fetchedAnimals = CoreDataManager.shared.fetchAnimals() else {
            print("Failed to fetch animals")
            return
        }
        
        
        // Organize appointments and animals into sections
        let animalsSection = Section.animal(title: NSLocalizedString("my_animals", comment: ""), items: fetchedAnimals)
        let appointmentsSection = Section.appointement(title:NSLocalizedString("next_appointments", comment: ""), items: fetchedAppointments)
        let otherSection = Section.other(title: NSLocalizedString("prev_appointments", comment: ""), items: fetchedAppointments)
        
        sections = [animalsSection,appointmentsSection, otherSection]
        collectionView.reloadData()
    }

    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        // Register cells
        collectionView.register(AnimalHomeCollectionViewCell.self, forCellWithReuseIdentifier: "AnimalHomeCollectionViewCell")
        collectionView.register(AppointementCollectionViewCell.self, forCellWithReuseIdentifier: "AppointementCollectionViewCell")
        collectionView.register(AppointmentCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentCollectionViewCell")
        
        // Register supplementary view
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .animal:
                return self.createAnimalLayout()
            case .appointement:
                return self.createAppoitementLayout()
            case .other:
                return self.createComingSoonLayout()
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
    
    private func createAppoitementLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 10, leading: 15, bottom: 30, trailing: 10)
        section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
        return section
    }
    
    private func createComingSoonLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

extension HomeView2Controller: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let cell: UICollectionViewCell
        switch section {
        case .animal(_, let items):
            let animalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalHomeCollectionViewCell", for: indexPath) as! AnimalHomeCollectionViewCell
            animalCell.setup(items[indexPath.row])
            cell = animalCell
        case .appointement(_, let items):
            let appointementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointementCollectionViewCell", for: indexPath) as! AppointementCollectionViewCell
            appointementCell.setup(items[indexPath.row])
            cell = appointementCell
        case .other(_, let items):
            let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCollectionViewCell", for: indexPath) as! AppointmentCollectionViewCell
            otherCell.configure(with: items[indexPath.row])
            cell = otherCell
        }
        return cell
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
            let selectedAnimal = items[indexPath.row]
            let animalDetailVC = AnimalDetailViewController(selectedAnimal: selectedAnimal)
            navigationController?.pushViewController(animalDetailVC, animated: true)
        case .appointement(_, let items):
            let selectedAppoitement = items[indexPath.row]
            print(selectedAppoitement)
            // TODO: Create AppointementDetailViewController
            //                let appointementDetailVC = AppointementDetailViewController(selectedAppoitement: selectedAppoitement)
            //                navigationController?.pushViewController(appointementDetailVC, animated: true)
        default:
            break
        }
    }
}

enum Section {
    case animal(title: String, items: [Animal])
    case appointement(title: String, items: [Appointement])
    case other(title: String, items: [Appointement])
    
    var title: String {
        switch self {
        case .animal(let title, _), .appointement(let title, _), .other(let title, _):
            return title
        }
    }
    
    var count: Int {
        switch self {
        case .animal(_, let items): return items.count
        case .appointement(_, let items): return items.count
        case .other(_, let items): return items.count
        }
    }
}
