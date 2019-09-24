//
//  Class Data.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/24/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit


struct ClassUIData {
    var cell: Int?
    var height: CGFloat?
}

struct ClassMenu {
    var img : String?
    var menu : String?
}

struct ClassBody {
    var data: String?
    var isFocus: Bool? = false
}

enum fileType {
    case image
    case file
}

struct FeedData {
    var user    : String?
    var userImg : String?
    var file     : [FeedFileData]? = nil
    var post    : String?
    var type    : fileType?
}
