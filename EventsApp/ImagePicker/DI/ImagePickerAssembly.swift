import Foundation
import UIKit

final class ImagePickerAssembly: NSObject, AssemblyProtocol {
    private(set) var assemblies: [AssemblyProtocol] = []

    private var navigationController: UINavigationController
    var parentAssembly: AssemblyProtocol?
    var onFinishPicking: (UIImage) -> Void = { _ in }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        navigationController.present(imagePickerVC, animated: true)
    }

    func childDidFinish(assembly: AssemblyProtocol) {
        if let index = assemblies.firstIndex(where: { firstAssembly -> Bool in
            return assembly === firstAssembly
        }) {
            assemblies.remove(at: index)
        }
    }
}

extension ImagePickerAssembly: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            onFinishPicking(image)
        }
        parentAssembly?.childDidFinish(assembly: self)
    }
}
