

import Foundation
import UIKit

final class AddEventAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    var parentAssembly: EventListAssembly?
    private var completion: (UIImage) -> () = { image in }

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }

    func start() {
        self.modalNavigationController = UINavigationController()
        let addEventVC = AddEventViewController.init()
        modalNavigationController?.setViewControllers([addEventVC], animated: true)
        let cellBuilder = EventCellBuilder()
        let addEventViewModel = AddEventViewModel(cellBuilder: cellBuilder)
        addEventViewModel.assembly = self
        addEventVC.viewModel = addEventViewModel
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true)
        }
    }

    func didFinish () {
        parentAssembly?.childDidFinish(assembly: self)
    }

    func showImagePicker( completion: @escaping (UIImage) -> ()) {
        guard let modalNavigationController = modalNavigationController else { return }
        self.completion = completion
        let imagePickerAssembly = ImagePickerAssembly(navigationController: modalNavigationController)
        imagePickerAssembly.parentAssembly = self
        imagePickerAssembly.onFinishPicking = { image in
            completion(image)
            modalNavigationController.dismiss(animated: true)
        }
        assemblies.append(imagePickerAssembly)
        imagePickerAssembly.start()
    }


    func childDidFinish(assembly: AssemblyProtocol) {
        if let index = assemblies.firstIndex(where: { firstAssembly -> Bool in
            return assembly === firstAssembly
        }) {
            assemblies.remove(at: index)
        }
    }

    func didFinishSaveEvent () {
        parentAssembly?.onUpdateEvent()
        navigationController.dismiss(animated: true)
    }

    deinit {
        print("Deinit from add event assembly")
    }

}

