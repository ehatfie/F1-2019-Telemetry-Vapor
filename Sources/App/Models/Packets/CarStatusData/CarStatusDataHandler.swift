//
//  CarStatusDataHandler.swift
//  App
//
//  Created by Erik Hatfield on 1/15/20.
//

import Foundation
import NIO

class CarStatusDataHandler: PacketHandler {
    typealias PacketType = CarStatusDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}
