import Foundation
import UIKit
import CoreData

final class EventDetailAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    weak var parentAssembly: EventListAssembly?
    private let eventId: NSManagedObjectID

    init(navigationController: UINavigationController, eventId: NSManagedObjectID) {
        self.navigationController = navigationController
        self.eventId = eventId
    }

    func start() {
        let eventDetailVC = EventDetailViewController.init()
        let eventDetailViewModel = EventDetailViewModel(eventId: eventId)
        eventDetailVC.viewModel = eventDetailViewModel
        navigationController.present(eventDetailVC, animated: true)
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

    deinit {
        print("Deinit from EventDetailAssembly")
    }

}

