//
//  FeedPollCell.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 8/19/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

struct FeedPollData {
    let id : Int
    let vote : Int
    let voters : [FeedPollVotersData]
    
    
}

struct FeedPollVotersData {
    let img : String
    let name : String
}

class FeedPollCell : BaseCell<FeedPollData> {
    override var data: FeedPollData! {
        didSet{
            
        }
    }
    
    
    
}
