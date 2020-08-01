import Foundation

extension Date {
    func timeRemaining (endDate: Date) -> String {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        guard let dateString = dateComponentsFormatter.string(from: self, to: endDate) else { return "" }
        return dateString
    }
}