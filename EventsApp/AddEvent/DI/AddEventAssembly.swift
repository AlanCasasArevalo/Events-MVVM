

import Foundation
import UIKit

final class AddEventAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController

    var parentAssembly: EventListAssembly?

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }

    func start() {
        let modalNavigationController = UINavigationController()
        let addEventVC = AddEventViewController.init()
        modalNavigationController.setViewControllers([addEventVC], animated: true)
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.assembly = self
        addEventVC.viewModel = addEventViewModel
        navigationController.present(modalNavigationController, animated: true)
    }

    func didFinishAddEvent () {
        parentAssembly?.childDidFinish(assembly: self)
    }

    deinit {
        print("Deinit from add event assembly")
    }

}

