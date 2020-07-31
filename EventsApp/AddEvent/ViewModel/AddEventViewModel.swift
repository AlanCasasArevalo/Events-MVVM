import Foundation

final class AddEventViewModel {

    var assembly: AddEventAssembly?

    func viewDidDisappear() {
        assembly?.didFinishAddEvent()
    }

    deinit {
        print("Deinit from AddEventViewModel")
    }
}
