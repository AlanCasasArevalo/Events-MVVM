
import Foundation
import UIKit

protocol AssemblyProtocol: class {
    var assemblies: [AssemblyProtocol] { get }
    func start()
}

final class AppAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var window: UIWindow

    init(window: UIWindow){
        self.window = window
    }

    func start() {
        let navigationVC = UINavigationController()
        let eventListAssembly = EventListAssembly(navigationController: navigationVC)
        assemblies.append(eventListAssembly)
        eventListAssembly.start()
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
    }
}

