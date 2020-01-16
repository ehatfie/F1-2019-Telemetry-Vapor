//
//  EventDataHandler.swift
//  App
//
//  Created by Erik Hatfield on 1/15/20.
//

import Foundation
import NIO

class EventDataHandler: PacketHandler {
    typealias PacketType = EventDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}
