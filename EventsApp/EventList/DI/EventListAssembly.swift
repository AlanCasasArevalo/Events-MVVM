//
// Created by Everis on 29/07/2020.
// Copyright (c) 2020 Alan Casas. All rights reserved.
//

import Foundation
import UIKit

final class EventListAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }

    func start() {
        let eventListVC = EventListViewController.init()
        navigationController.setViewControllers([eventListVC], animated: false)
    }
}

