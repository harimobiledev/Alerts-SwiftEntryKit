//
//  InputView.swift
//  Popups
//
//  Created by Hari Keerthipati on 04/09/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import Foundation
import SwiftEntryKit

enum FormStyle {
    case light
    case dark
    
    var imageSuffix: String {
        switch self {
        case .dark:
            return "_light"
        case .light:
            return "_dark"
        }
    }
    
    var title: EKProperty.LabelStyle {
        
        let font = MainFont.medium.with(size: 16)
        switch self {
        case .dark:
            return .init(font: font, color: .white, alignment: .center)
        case .light:
            return .init(font: font, color: .gray, alignment: .center)
        }
    }
    
    var buttonTitle: EKProperty.LabelStyle {
        let font = MainFont.bold.with(size: 16)
        switch self {
        case .dark:
            return .init(font: font, color: .black)
        case .light:
            return .init(font: font, color: .white)
        }
    }
    
    var buttonBackground: UIColor {
        switch self {
        case .dark:
            return .white
        case .light:
            return .red
        }
    }
    
    var placeholder: EKProperty.LabelStyle {
        let font = MainFont.light.with(size: 14)
        switch self {
        case .dark:
            return .init(font: font, color: UIColor(white: 0.8, alpha: 1))
        case .light:
            return .init(font: font, color: UIColor(white: 0.5, alpha: 1))
        }
    }
    
    var text: EKProperty.LabelStyle {
        let font = MainFont.light.with(size: 14)
        switch self {
        case .dark:
            return .init(font: font, color: .white)
        case .light:
            return .init(font: font, color: .black)
        }
    }
    
    var separator: UIColor {
        return .init(white: 0.8784, alpha: 0.6)
    }
}

class InputView {
    
    private static var alertAttributes: EKAttributes {
        var attributes: EKAttributes
        attributes = .float
        attributes.windowLevel = .normal
        attributes.position = .center
        attributes.displayDuration = .infinity
        attributes.entranceAnimation = .init(translate: .init(duration: 0.65, anchorPosition: .bottom,  spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.65, anchorPosition: .top, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0))))
        
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        
        attributes.entryBackground = .color(color: .white)
        attributes.screenBackground = .color(color: UIColor(white: 50.0/255.0, alpha: 0.3))
        
        attributes.border = .value(color: UIColor(white: 0.6, alpha: 1), width: 1)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 3))
        attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
        attributes.statusBar = .light
        
        attributes.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        return attributes
    }
    
    class func showForm(title: String, textFields: [EKProperty.TextFieldContent], cancelTitle: String, handler: @escaping ([String]) -> Swift.Void)
    {
        let style = FormStyle.light
        let title = EKProperty.LabelContent(text: title, style: style.title)

        let button = EKProperty.ButtonContent(label: .init(text: cancelTitle, style: style.buttonTitle), backgroundColor: style.buttonBackground, highlightedBackgroundColor: style.buttonBackground.withAlphaComponent(0.8)) {
            var texts = [String]()
            for textfield in textFields {
                
                print("output count===\(textfield.output.count, textfield.output)")
                texts.append(textfield.output)
            }
            handler(texts)
            SwiftEntryKit.dismiss()
        }
        let contentView = EKFormMessageView(with: title, textFieldsContent: textFields, buttonContent: button)
        SwiftEntryKit.display(entry: contentView, using: InputView.alertAttributes)
    }
    
    class func field(by name: String, imageName: String, keyboardType: UIKeyboardType, isSecure: Bool) -> EKProperty.TextFieldContent {
        let style = FormStyle.light
        let textStyle = style.text
        let separatorColor = style.separator
        let placeholder = EKProperty.LabelContent(text: name, style: style.placeholder)
        return .init(keyboardType: keyboardType, placeholder: placeholder, textStyle: textStyle, isSecure: isSecure, leadingImage: UIImage(named: imageName), bottomBorderColor: separatorColor)
    }
}
