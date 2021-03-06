import Foundation
import UIKit
import CoreData


final class EventListAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    var onUpdateEvent = {}

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let eventListVC = EventListViewController.init()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.assembly = self
        onUpdateEvent = eventListViewModel.reloadData
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

    func onSelect(eventId: NSManagedObjectID ) {
        let eventDetail = EventDetailAssembly(navigationController: navigationController, eventId: eventId)
        assemblies.append(eventDetail)
        eventDetail.parentAssembly = self
        eventDetail.start()
    }



}

