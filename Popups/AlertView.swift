//
//  AlertView.swift
//  Popups
//
//  Created by Hari Keerthipati on 27/08/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import UIKit
import SwiftEntryKit

enum ActionStyle {
    case general
    case cancel
}

class AlertAction {
    var title: String!
    var style: ActionStyle!
    var completion: ((AlertAction) -> Swift.Void)?
    init(actionTitle: String, actionStyle: ActionStyle, handler: ((AlertAction) -> Swift.Void)? = nil) {
        title = actionTitle
        style = actionStyle
        completion = handler
    }
}

class AlertView {

    var actions = [AlertAction]()
    var title: String!
    var message: String!
    var imageName: String!
    init(alertTitle: String, alertMessage: String, alertImageName: String?) {
        title = alertTitle
        message = alertMessage
        imageName = alertImageName
    }
    
    func addAction(action: AlertAction) {
        self.actions.append(action)
    }
    
    private static var alertAttributes: EKAttributes {
        var attributes: EKAttributes
        
        attributes = .centerFloat
        attributes.hapticFeedbackType = .success
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.screenBackground = .color(color: UIColor.white)
        attributes.entryBackground = .color(color: .white)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)), scale: .init(from: 0.6, to: 1, duration: 0.7), fade: .init(from: 0.8, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(scale: .init(from: 1, to: 0.7, duration: 0.3), fade: .init(from: 1, to: 0, duration: 0.3))
        attributes.displayDuration = .infinity
        attributes.border = .value(color: .black, width: 0.5)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 5))
        attributes.statusBar = .dark
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        return attributes
    }
    
    func present() {
        
        let title = EKProperty.LabelContent(text: self.title, style: .init(font: MainFont.medium.with(size: 15), color: .black))
        let description = EKProperty.LabelContent(text: self.message, style: .init(font: MainFont.light.with(size: 13), color: .black))
        let image = EKProperty.ImageContent(imageName: self.imageName, size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        
        let buttonFont = MainFont.medium.with(size: 16)
        var ekButtons = [EKProperty.ButtonContent]()
        for action in actions
        {
            let textColor = (action.style == .general) ? UIColor.gray : UIColor.purple
            let buttonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: textColor)
            let buttonLabel = EKProperty.LabelContent(text: action.title, style: buttonLabelStyle)
            let button = EKProperty.ButtonContent(label: buttonLabel, backgroundColor: .clear, highlightedBackgroundColor:  UIColor.gray) {
                SwiftEntryKit.dismiss()
                action.completion?(action)
            }
            ekButtons.append(button)
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(with: ekButtons, separatorColor: UIColor.gray, expandAnimatedly: true)
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, imagePosition: .left, buttonBarContent: buttonsBarContent)
        let contentView = EKAlertMessageView(with: alertMessage)
        
        SwiftEntryKit.display(entry: contentView, using: AlertView.alertAttributes)
    }
    
    static func showInfoAlert(title: String, cancelTitle: String, message: String, imageName: String?) {
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 15), color: .black))
        let description = EKProperty.LabelContent(text: message, style: .init(font: MainFont.light.with(size: 13), color: .black))
        var image: EKProperty.ImageContent?
        if imageName != nil {
            image = EKProperty.ImageContent(imageName: imageName!, size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit)
        }
        else{
            image = EKProperty.ImageContent(imageName: "", size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit)
        }
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let buttonFont = MainFont.medium.with(size: 16)
        
        let okButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: UIColor.red)
        let okButtonLabel = EKProperty.LabelContent(text: cancelTitle, style: okButtonLabelStyle)
        
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor: UIColor.blue) {
            SwiftEntryKit.dismiss()
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(with: [okButton], separatorColor: UIColor.gray, expandAnimatedly: true)
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, imagePosition: .left, buttonBarContent: buttonsBarContent)
        let contentView = EKAlertMessageView(with: alertMessage)
        SwiftEntryKit.display(entry: contentView, using: alertAttributes)
    }
}
