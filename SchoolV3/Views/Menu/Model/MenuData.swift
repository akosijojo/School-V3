//
//  MenuData.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 8/14/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Inbox
    case Notifications
    case Settings
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Inbox: return "Inbox"
        case .Notifications: return "Notifications"
        case .Settings: return "Settings"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile:
            return UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .Inbox:
            return UIImage(named: "inbox")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .Notifications:
            return UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .Settings:
            return UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        }
    }
}

