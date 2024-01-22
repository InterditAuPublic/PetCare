import UIKit

class VeterinarianTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var veterinarian: Veterinarian?
    private var vc = UIViewController()
    
    // MARK: - UI Components
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "veterinary")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let phoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.green, for: .normal)
        button.setTitle("Call", for: .normal)
        return button
    }()
    
    let navigationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Navigate", for: .normal)
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        // Create a vertical stack view for the layout
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8 // Adjust the spacing between components
        
        // Add subviews to the stack view
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(phoneButton)
        stackView.addArrangedSubview(navigationButton)
        
        // Add the stack view to the contentView
        contentView.addSubview(stackView)
        
        // Set constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
        // Set the height constraint for the image view
        iconImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // MARK: - Icon Image Views
    

    // MARK: - Tap Gesture Handlers
    @objc private func phoneButtonTapped() {
        guard let phoneNumber = veterinarian?.phone, !phoneNumber.isEmpty else {
            // Handle the case where there is no phone number available
            // Display an alert or take appropriate action
            return
        }
        
        if let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func navigationButtonTapped() {
        guard let veterinarian = veterinarian,
              let address = veterinarian.address,
              let city = veterinarian.city else {
            // Handle the case where there is no address or city available
            // Display an alert or take appropriate action
            return
        }
        
        let alertController = UIAlertController(title: "Choose Map Application", message: nil, preferredStyle: .actionSheet)
        
        findApplicationCanOpenAddress(address: address, city: city).forEach { alertController.addAction($0) }
        
        // Present the alert controller
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self
            popoverController.sourceRect = CGRect(x: self.bounds.midX, y: self.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        let vc = findViewController()
        vc!.present(alertController, animated: true)
    }
    
    // MARK: - Map Applications
    
    private func openInAppleMaps(address: String, city: String) {
        if let appleMapsURL = URL(string: "http://maps.apple.com/?address=\(address),\(city)") {
            UIApplication.shared.open(appleMapsURL, options: [:], completionHandler: nil)
        }
    }

    private func openInGoogleMaps(address: String, city: String) {
        if let googleMapsURL = URL(string: "http://maps.google.com/maps/?q=\(address),\(city)") {
            UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
        }
    }

    private func openInWaze(address: String, city: String) {
        if let wazeURL = URL(string: "http://waze.com/?address=\(address),\(city)") {
            UIApplication.shared.open(wazeURL, options: [:], completionHandler: nil)
        }
    }
    
    private func findApplicationCanOpenAddress(address: String, city: String) -> [UIAlertAction] {
        var mapApplications: [UIAlertAction] = []
        
        if UIApplication.shared.canOpenURL(URL(string: "http://maps.apple.com/")!) {
            let appleMapsAction = UIAlertAction(title: "Apple Maps", style: .default) { _ in
                self.openInAppleMaps(address: address, city: city)
            }
            mapApplications.append(appleMapsAction)
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "http://comgooglemaps/")!) {
            let googleMapsAction = UIAlertAction(title: "Google Maps", style: .default) { _ in
                self.openInGoogleMaps(address: address, city: city)
            }
            mapApplications.append(googleMapsAction)
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "http://waze.com/")!) {
            let wazeAction = UIAlertAction(title: "Waze", style: .default) { _ in
                self.openInWaze(address: address, city: city)
            }
            mapApplications.append(wazeAction)
        }
        
        let copyAddressAction = UIAlertAction(title: "Copy Address", style: .default) { _ in
            UIPasteboard.general.string = "\(address), \(city)"
            // Show a toast message
            let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 75, y: self.frame.size.height/2, width: 150, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center
            toastLabel.text = "Address copied"
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            self.addSubview(toastLabel)
            UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
        mapApplications.append(copyAddressAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        mapApplications.append(cancelAction)
        
        return mapApplications
    }
    
    // MARK: - Configuration
    
    func configure(with veterinarian: Veterinarian) {
        nameLabel.text = veterinarian.name
        
        var fullAddress = ""
        if let address = veterinarian.address {
            fullAddress += address + ", "
        }
        if let zipcode = veterinarian.zipcode {
            fullAddress += zipcode + " "
        }
        if let city = veterinarian.city {
            fullAddress += city + ", "
        }
        if let country = veterinarian.country {
            fullAddress += country
        }
        addressLabel.text = fullAddress
        
        // Set the actions for buttons if needed
        phoneButton.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        navigationButton.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        
        // Store the veterinarian model for later use in button actions
        self.veterinarian = veterinarian
    }
}
