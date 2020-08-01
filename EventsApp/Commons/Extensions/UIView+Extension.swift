import UIKit

enum Edge {
    case top
    case bottom
    case right
    case left
}

extension UIView {
    func pinToSuperView(edges: [Edge] = [.top, .bottom, .right, .left], constant: CGFloat = 0) {
        guard let superview = superview else { return }
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            }
        }
    }
}
