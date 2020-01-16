//
//  MarshalZone.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct MarshalZone {
    let zoneStart: Float? // fraction (0..1) of way through the lap the zone starts
    let zoneFlag: Int? //Int8 // -1 invalid/unknown, 0 = none, 1 = green, 2 = blue, 3 = yellow, 4 = red
    
    init(data: ByteBuffer) throws {
        var dataCopy = data
        self.zoneStart = dataCopy.readFloat()
        self.zoneFlag = dataCopy.readInt(as: UInt8.self)
    }
}
