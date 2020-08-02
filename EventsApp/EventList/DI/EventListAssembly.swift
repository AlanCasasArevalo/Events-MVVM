import Foundation
import UIKit
import CoreData


final class EventListAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    var onSaveEvent = {}

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let eventListVC = EventListViewController.init()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.assembly = self
        onSaveEvent = eventListViewModel.reloadData
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

    func onSelect(id: NSManagedObjectID ) {
        print(id)
    }

}

