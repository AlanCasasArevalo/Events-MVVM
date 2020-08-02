
import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    weak var viewModel: EventDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    deinit {
        print("Deinit from EventDetailViewController")
    }
}
