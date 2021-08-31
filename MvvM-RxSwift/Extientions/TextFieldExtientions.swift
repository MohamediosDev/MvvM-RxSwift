//
//  TextFieldExtientions.swift
//  MvvM-RxSwift
//
//  Created by Soda on 8/28/21.
//

import UIKit


class CustomeTextFiled: UITextField {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1.5
        layer.borderColor = #colorLiteral(red: 0.2005228698, green: 0.3109551966, blue: 0.533769846, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
}

class CustomButtom: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        clipsToBounds = true
        
    }
}

class CustomView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.maskedCorners = [.topLeft,.topRight]
        clipsToBounds = true
        layer.cornerRadius = 40
    }
}
extension CACornerMask {
    
    /// [.topLeft, .topRight, .BottomLeft, .BottomRight]
    static var all: CACornerMask {
        return [.topLeft, .topRight, .bottomLeft, .bottomRight]
    }
    /// layerMaxXMinYCorner
    static var topRight: CACornerMask {
        return .layerMaxXMinYCorner
    }
    /// layerMinXMinYCorner
    static var topLeft: CACornerMask {
        return .layerMinXMinYCorner
    }
    /// layerMinXMaxYCorner
    static var bottomLeft: CACornerMask {
        return .layerMinXMaxYCorner
    }
    /// layerMaxXMaxYCorner
    static var bottomRight: CACornerMask {
        return .layerMaxXMaxYCorner
    }
    /// [.bottomLeft, .bottomRight]
    static var allBottom: CACornerMask {
        return [.bottomLeft, .bottomRight]
    }
    /// [.topLeft, .topRight]
    static var allTop: CACornerMask {
        return [.topLeft, .topRight]
    }
    /// [.topRight, .bottomRight]
    static var allRight: CACornerMask {
        return [.topRight, .bottomRight]
    }
    /// [.bottomLeft, .bottomRight]
    static var allLeft: CACornerMask {
        return [.bottomLeft, .bottomRight]
    }
    
    /// all angles but `excluding`
    static func all(excluding: CACornerMask) -> CACornerMask {
        switch excluding {
        case .bottomLeft: return [.topLeft, .topRight, .bottomRight]
        case .bottomRight: return [.topLeft, .topRight, .bottomLeft]
        case .topLeft: return [.topRight, .bottomLeft, .bottomRight]
        case .topRight: return [.topLeft, .bottomLeft, .bottomRight]
        default: return .all
        }
    }
}


class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setupView()
    }
    
    
    private func setupView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
    }
    
}


