import Foundation
import UIKit
import CoreData

final class EventDetailAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    weak var parentAssembly: EventListAssembly?
    private let eventId: NSManagedObjectID
    var onUpdateEvent = {
    }

    init(navigationController: UINavigationController, eventId: NSManagedObjectID) {
        self.navigationController = navigationController
        self.eventId = eventId
    }

    func start() {
        let eventDetailVC = EventDetailViewController.init()
        let eventDetailViewModel = EventDetailViewModel(eventId: eventId)
        eventDetailViewModel.assembly = self
        onUpdateEvent = {
            eventDetailViewModel.reload()
            self.parentAssembly?.onUpdateEvent()
        }
        eventDetailVC.viewModel = eventDetailViewModel
        navigationController.pushViewController(eventDetailVC, animated: true)
    }

    func didFinish() {
        parentAssembly?.childDidFinish(assembly: self)
    }

    func childDidFinish(assembly: AssemblyProtocol) {
        if let index = assemblies.firstIndex(where: { firstAssembly -> Bool in
            return assembly === firstAssembly
        }) {
            assemblies.remove(at: index)
        }
    }

    func onEditEvent(event: Event) {
        let editEventAssembly = EditEventAssembly(navigationController: navigationController, event: event)
        editEventAssembly.parentAssembly = self
        assemblies.append(editEventAssembly)
        editEventAssembly.start()
    }

    deinit {
        print("Deinit from EventDetailAssembly")
    }

}

