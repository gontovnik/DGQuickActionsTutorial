//
//  ViewController.swift
//  DGQuickActionsTutorial
//
//  Created by Danil Gontovnik on 9/27/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

import UIKit

extension UIApplicationShortcutIconType {
    var toString: String {
        switch self {
        case .Compose: return "Compose"
        case .Play: return "Play"
        case .Pause: return "Pause"
        case .Add: return "Add"
        case .Location: return "Location"
        case .Search: return "Search"
        case .Share: return "Share"
        }
    }
    
    init?(string: String) {
        switch string {
        case "Compose": self.init(rawValue: UIApplicationShortcutIconType.Compose.rawValue)
        case "Play": self.init(rawValue: UIApplicationShortcutIconType.Play.rawValue)
        case "Pause": self.init(rawValue: UIApplicationShortcutIconType.Pause.rawValue)
        case "Add": self.init(rawValue: UIApplicationShortcutIconType.Add.rawValue)
        case "Location": self.init(rawValue: UIApplicationShortcutIconType.Location.rawValue)
        case "Search": self.init(rawValue: UIApplicationShortcutIconType.Search.rawValue)
        case "Share": self.init(rawValue: UIApplicationShortcutIconType.Share.rawValue)
        default: return nil
        }
    }
    
    static var allTypesToStrings: [String] {
        return [UIApplicationShortcutIconType.Compose.toString, UIApplicationShortcutIconType.Play.toString, UIApplicationShortcutIconType.Pause.toString, UIApplicationShortcutIconType.Add.toString, UIApplicationShortcutIconType.Location.toString, UIApplicationShortcutIconType.Search.toString, UIApplicationShortcutIconType.Share.toString]
    }
}

class ViewController: UIViewController {

    // MARK: -
    // MARK: Vars
    
    private let titleTextField = UITextField()
    private let subtitleTextField = UITextField()
    private var iconTypeSegmentedControl = UISegmentedControl(items: UIApplicationShortcutIconType.allTypesToStrings)
    private let updateButton = UIButton(type: .System)
    
    // MARK: -
    
    override func loadView() {
        super.loadView()
        titleTextField.placeholder = "Title"
        titleTextField.delegate = self
        view.addSubview(titleTextField)
        
        subtitleTextField.placeholder = "Subtitle"
        subtitleTextField.delegate = self
        view.addSubview(subtitleTextField);
        
        updateButton.setTitle("Update shortcut", forState: .Normal)
        updateButton.addTarget(self, action: Selector("updateDynamicAction"), forControlEvents: .TouchUpInside)
        view.addSubview(updateButton)
        
        iconTypeSegmentedControl.selectedSegmentIndex = 0
        view.addSubview(iconTypeSegmentedControl)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "viewTapped"))
    }

    // MARK: -
    // MARK: Methods
    
    func viewTapped() {
        view.endEditing(true)
    }
    
    func updateDynamicAction() {
        guard let title = titleTextField.text else {
            UIApplication.sharedApplication().shortcutItems = nil
            return
        }
        
        let type = DGShortcutItemType.Dynamic.type
        let shortcutIconType = UIApplicationShortcutIconType(string: iconTypeSegmentedControl.titleForSegmentAtIndex(iconTypeSegmentedControl.selectedSegmentIndex)!)!
        let icon = UIApplicationShortcutIcon(type: shortcutIconType)
        
        let dynamicShortcut = UIApplicationShortcutItem(type: type, localizedTitle: title, localizedSubtitle: subtitleTextField.text, icon: icon, userInfo: nil)
        UIApplication.sharedApplication().shortcutItems = [dynamicShortcut]
    }

    // MARK: -
    // MARK: Layout
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width = view.bounds.width
        
        let horizontalMargin: CGFloat = 20.0
        let elementHeight: CGFloat = 40.0
        let verticalSpacing: CGFloat = 20.0
        
        titleTextField.frame = CGRect(x: horizontalMargin, y: 50.0, width: width - 2 * horizontalMargin, height: elementHeight)
        subtitleTextField.frame = CGRectOffset(titleTextField.frame, 0.0, elementHeight + verticalSpacing)
        iconTypeSegmentedControl.frame = CGRectOffset(subtitleTextField.frame, 0.0, elementHeight + verticalSpacing)
        updateButton.frame = CGRectOffset(iconTypeSegmentedControl.frame, 0.0, elementHeight + verticalSpacing)
    }

}

// MARK: -
// MARK: UITextField Delegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == titleTextField {
            subtitleTextField.becomeFirstResponder()
        } else if textField == subtitleTextField {
            subtitleTextField.resignFirstResponder()
        }
        
        return true
    }
    
}
