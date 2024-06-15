//
//  Item.swift
//  journal_app
//
//  Created by Jacob Sheiner on 6/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
