
import UIKit

extension UIImage {
    func sameAspectRation (newHeight: CGFloat) -> UIImage {
        let scale  = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let newImage = UIGraphicsImageRenderer(size: newSize).image { context in
            self.draw(in: .init(origin: .zero, size: newSize))
        }
        return newImage
    }
}
