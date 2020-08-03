//
// Created by Everis on 03/08/2020.
//

import UIKit
import CoreData

protocol EventServicesProtocol {
    func performData(action: EventServices.EventAction, inputData: EventServices.EventInputData)
    func getEvent(elementId: NSManagedObjectID) -> Event?
    func getAllEvent() -> [Event]
}

class EventServices: EventServicesProtocol {

    private let coreDataManager: CoreDataManager

    enum EventAction {
        case add
        case update(Event)
    }

    struct EventInputData {
        let name: String, date: Date, image: UIImage
    }

    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }

    func performData(action: EventAction, inputData: EventInputData) {
        var event: Event
        switch action {
        case .add:
            event = Event(context: coreDataManager.manageObjectContext)
        case .update(let eventToUpdate):
            event = eventToUpdate
        }

        let resizedImage = inputData.image.sameAspectRation(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(inputData.name, forKey: CoreDataConstants.saveDataLocallyName)
        event.setValue(inputData.date, forKey: CoreDataConstants.saveDataLocallyDate)
        event.setValue(imageData, forKey: CoreDataConstants.saveDataLocallyImageData)
        coreDataManager.save()
    }

    func getEvent(elementId: NSManagedObjectID) -> Event? {
        coreDataManager.getElementById(elementId: elementId)
    }

    func getAllEvent() -> [Event] {
        coreDataManager.getAllElementsSaved()
    }

}