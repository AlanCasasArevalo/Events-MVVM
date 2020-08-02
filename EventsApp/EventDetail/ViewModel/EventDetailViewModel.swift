import Foundation

final class EventDetailViewModel {

    weak var assembly: EventDetailAssembly?

    func viewDidDisappear() {
        assembly?.didFinish()
    }

    func viewDidLoad() {
    }

    deinit {
        print("Deinit from EventDetailViewModel")
    }
}

