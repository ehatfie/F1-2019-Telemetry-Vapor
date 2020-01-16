//
//  LapDataHandler.swift
//  App
//
//  Created by Erik Hatfield on 1/15/20.
//

import Foundation
import NIO

class LapDataHandler: PacketHandler {
    typealias PacketType = LapDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}
