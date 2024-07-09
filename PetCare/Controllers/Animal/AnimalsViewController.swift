import UIKit

class AnimalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NoAnimalsDelegate {

    var animals: [Animal] = []
    var tableView: UITableView!
    var noAnimalView: NoAnimalView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchAnimals()
        updateUI()
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = addButton
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private func fetchAnimals() {
        animals = CoreDataManager.shared.fetchAnimals() ?? []
    }

    private func updateUI() {
        if animals.isEmpty {
            showNoAnimalsView()
        } else {
            tableView.isHidden = false
            tableView.reloadData()
            noAnimalView?.removeFromSuperview()
            noAnimalView = nil
        }
    }
    
    private func showNoAnimalsView() {
      tableView.isHidden = true
      if noAnimalView == nil {
          noAnimalView = NoAnimalView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
          noAnimalView?.center = view.center
          noAnimalView?.delegate = self
          view.addSubview(noAnimalView!)
    }
  }

    @objc internal func didTapAddButton() {
        navigationController?.pushViewController(AddAnimalViewController(), animated: true)
    }
    
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalTableViewCell.reuseIdentifier, for: indexPath) as! AnimalTableViewCell
        let animal = animals[indexPath.row]
        cell.configure(with: animal)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Show alert to confirm deletion of animal, if it has appointments show a warning
            let animal = animals[indexPath.row]
            let alert = UIAlertController(title: NSLocalizedString("delete_animal_title", comment: ""), message: NSLocalizedString("delete_animal_message", comment: ""), preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { (action) in
                CoreDataManager.shared.deleteAnimal(animal: animal)
                self.animals.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.updateUI()
            }))
            present(alert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnimal = animals[indexPath.row]
        let animalDetailViewController = AnimalDetailsViewController(animal: selectedAnimal)
        navigationController?.pushViewController(animalDetailViewController, animated: true)
    }
}
