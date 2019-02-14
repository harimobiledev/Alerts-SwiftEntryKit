//
//  ViewController.swift
//  Popups
//
//  Created by Hari Keerthipati on 21/08/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func simpleAlertAction()
    {
        AlertView.showInfoAlert(title: "Title", cancelTitle: "Cancel Button", message: "This is info alert", imageName: "ic_books")
    }
    
    @IBAction func formButtonAction()
    {
        let nameField = InputView.field(by: "Name", imageName: "ic_info_outline", keyboardType: .namePhonePad, isSecure: false)
        let passwordField = InputView.field(by: "Password", imageName: "ic_info_outline", keyboardType: .namePhonePad, isSecure: true)
        let textFields = [nameField, passwordField]
        InputView.showForm(title: "Enter Name", textFields: textFields, cancelTitle: "Ok") { (inputs) in
            print("input===\(inputs)")
        }
    }
    
    @IBAction func alertWithOptionsAction()
    {
        let alert = AlertView(alertTitle: "Hello", alertMessage: "This is alert in UIALERTview logic", alertImageName: "ic_books")
        let alertAction = AlertAction(actionTitle: "Ok", actionStyle: .general) { (action) in
            print("title===\(String(describing: action.title))")
        }
        let cancelAction = AlertAction(actionTitle: "Cancel", actionStyle: .cancel) { (action) in
            print("title===\(String(describing: action.title))")
        }
        let noAction = AlertAction(actionTitle: "No", actionStyle: .general)
        alert.addAction(action: alertAction)
        alert.addAction(action: cancelAction)
        alert.addAction(action: noAction)
        alert.present()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}

