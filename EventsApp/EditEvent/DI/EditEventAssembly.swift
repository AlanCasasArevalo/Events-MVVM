import Foundation
import UIKit

final class EditEventAssembly: AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    weak var parentAssembly: EventDetailAssembly?
    private var completion: (UIImage) -> () = { image in }
    var event: Event

    init(navigationController: UINavigationController, event: Event) {
        self.navigationController = navigationController
        self.event = event
    }

    func start() {
        let editEventVC = EditEventViewController.init()
        let editEventViewModel = EditEventViewModel(cellBuilder: EventCellBuilder(), event: event)
        editEventVC.viewModel = editEventViewModel
        editEventViewModel.assembly = self
        navigationController.pushViewController(editEventVC, animated: true)
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

    func didFinishUpdateEvent () {
        parentAssembly?.onUpdateEvent()
        navigationController.popViewController(animated: true)
    }

    func showImagePicker( completion: @escaping (UIImage) -> ()) {
        self.completion = completion
        let imagePickerAssembly = ImagePickerAssembly(navigationController: navigationController)
        imagePickerAssembly.parentAssembly = self
        imagePickerAssembly.onFinishPicking = { image in
            completion(image)
            self.navigationController.dismiss(animated: true)
        }
        assemblies.append(imagePickerAssembly)
        imagePickerAssembly.start()
     }

    deinit {
        print("Deinit from EditEventAssembly")
    }

}

