

import Foundation
import UIKit

final class AddEventAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }

    func start() {
        let addEventVC = AddEventViewController.init()
        let addEventViewModel = AddEventViewModel()
        addEventVC.viewModel = addEventViewModel
        navigationController.present(addEventVC, animated: true)
    }

    
}

