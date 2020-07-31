import Foundation
import UIKit

final class EventListAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let eventListVC = EventListViewController.init()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.assembly = self
        eventListVC.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListVC], animated: false)
    }

    func startAddEvent() {
        let addEventAssembly = AddEventAssembly(navigationController: navigationController)
        assemblies.append(addEventAssembly)
        addEventAssembly.parentAssembly = self
        addEventAssembly.start()
    }

    func childDidFinish(assembly: AssemblyProtocol) {
        if let index = assemblies.firstIndex(where: { firstAssembly -> Bool in
          return assembly === firstAssembly
        }) {
            assemblies.remove(at: index)
        }
    }

}

