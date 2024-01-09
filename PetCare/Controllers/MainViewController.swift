
import UIKit

class MainViewController: UIViewController {

    private var animationView: LoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureAndShowAnimationView()
    }

    private func configureAndShowAnimationView() {
        animationView = LoadingView()
        animationView?.modalPresentationStyle = .fullScreen
        present(animationView!, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hideAnimationViewAndLoadMainView()
            }
        }
    }

    private func hideAnimationViewAndLoadMainView() {
           animationView?.dismiss(animated: true)
           let navigationController = TabBarController()
           navigationController.modalPresentationStyle = .fullScreen
           present(navigationController, animated: true)
       }
}
