
import UIKit

class AddEventViewController: UIViewController {

    var viewModel: AddEventViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("Deinit from AddEventViewController")
    }
}
