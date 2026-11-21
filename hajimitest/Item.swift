//
//  Item.swift
//  hajimitest
//
//  Created by bemly on 2026/11/21.
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
