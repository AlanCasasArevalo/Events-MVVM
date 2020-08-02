

import Foundation
import UIKit

final class EventDetailAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    weak var parentAssembly: EventListAssembly?

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }

    func start() {
        self.modalNavigationController = UINavigationController()
        let eventDetailVC = EventDetailViewController.init()
        modalNavigationController?.setViewControllers([eventDetailVC], animated: true)
        let eventDetailViewModel = EventDetailViewModel()
        eventDetailViewModel.assembly = self
        eventDetailVC.viewModel = eventDetailViewModel
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true)
        }
    }

    func didFinish () {
        parentAssembly?.childDidFinish(assembly: self)
    }

    func childDidFinish(assembly: AssemblyProtocol) {
        if let index = assemblies.firstIndex(where: { firstAssembly -> Bool in
            return assembly === firstAssembly
        }) {
            assemblies.remove(at: index)
        }
    }

    deinit {
        print("Deinit from EventDetailAssembly")
    }

}

