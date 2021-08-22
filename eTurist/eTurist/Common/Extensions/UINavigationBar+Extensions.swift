//
//  UINavigationBar+Extensions.swift
//  eTurist
//
//  Created by Marko on 19.08.2021..
//

import UIKit

class UINavigationBarGradientView: UIView {

    enum Point {
        case topCenter, bottomCenter
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
            case .topCenter: return CGPoint(x: 0.5, y: 0)
            case .bottomCenter: return CGPoint(x: 0.5, y: 1)
            case .topRight: return CGPoint(x: 1, y: 0)
            case .topLeft: return CGPoint(x: 0, y: 0)
            case .bottomRight: return CGPoint(x: 1, y: 1)
            case .bottomLeft: return CGPoint(x: 0, y: 1)
            case .custom(let point): return point
            }
        }
    }

    private weak var gradientLayer: CAGradientLayer!

    convenience init(colors: [UIColor], startPoint: Point = .topLeft,
                     endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        self.init(frame: .zero)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        backgroundColor = .clear
    }

    func set(colors: [UIColor], startPoint: Point = .topLeft,
             endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        parentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.frame = frame
        superview?.addSubview(self)
    }
}


extension UINavigationBar {
    func setBlurBackground() {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        let blurView = UIView()
        blurView.setBlur()
        blurView.cornerRadius = 2
        backgroundView.insertSubview(blurView, at: 0)
        backgroundView.cornerRadius = 2
    }
    
    func setGradientBackground(colors: [UIColor],
                               startPoint: UINavigationBarGradientView.Point = .topCenter,
                               endPoint: UINavigationBarGradientView.Point = .bottomCenter,
                               locations: [NSNumber] = [0, 1]) {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard let gradientView = backgroundView.subviews.first(where: { $0 is UINavigationBarGradientView }) as? UINavigationBarGradientView else {
            let gradientView = UINavigationBarGradientView(colors: colors, startPoint: startPoint,
                                                           endPoint: endPoint, locations: locations)
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            backgroundView.dropShadow()
            return
        }
        gradientView.set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
    }
    
    func removeGradientBackground(){
        
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        let lastView = backgroundView.subviews.last
        lastView?.removeFromSuperview()
    }
}
