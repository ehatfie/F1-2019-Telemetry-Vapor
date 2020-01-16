//
//  PacketCarTelemetryData.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct CarTelemetryDataPacket {
    let header: PacketHeader
    let carTelemetryData: [CarTelemetryData]
    let buttonStatus: Int // uint32 fit flags specifying which buttons are being pressed
    
    init(header: PacketHeader, data: ByteBuffer) throws {
        self.header = header
        
        let dataCopy = data
        self.carTelemetryData = []
        self.buttonStatus = -1
    }
}
