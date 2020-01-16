//
//  SessionDataHandler.swift
//  App
//
//  Created by Erik Hatfield on 1/15/20.
//

import Foundation
import NIO

class SessionDataHandler: PacketHandler {
    typealias PacketType = SessionDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}
