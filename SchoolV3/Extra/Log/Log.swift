//
//  Log.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/23/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

let dateFormat = DateFormatter()

class myLog {
    var showLogs : Bool = false

    func info(_ message: String){
        self.showLogs(message: " 💙 : \(message)")
    }
    
    func showLogs(message: String) {
        dateFormat.dateFormat = "HH:mm:ss"
        let time = dateFormat.string(from: Date())
        print(time + message)
    }
    
    func success(_ message: String){
        self.showLogs(message: " 💚 : \(message)")
    }
    
    func warning(_ message: String){
        self.showLogs(message: " 💛 : \(message)")
    }
    
    func danger(_ message: String){
        self.showLogs(message: " ❤️ : \(message)")
    }
    
    
    //    "💜 "     // silver
    //    "💚 "        // green
    //    "💙 "         // blue
    //    "💛 "     // yellow
    //    "❤️ "
}
