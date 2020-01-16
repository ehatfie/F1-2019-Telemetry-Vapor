//
//  CarTelemetryDataHandler.swift
//  App
//
//  Created by Erik Hatfield on 1/15/20.
//

import Foundation
import NIO

class CarTelemetryDataHandler: PacketHandler {
    typealias PacketType = CarTelemetryDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}
