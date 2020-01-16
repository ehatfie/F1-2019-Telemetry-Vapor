//
//  CarStatusDataPacket.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct CarStatusDataPacket {
    let header: PacketHeader
    let carStatusData: [CarStatusData]
    
    init(header: PacketHeader, data: ByteBuffer) throws {
        self.header = header
        self.carStatusData = []
    }
}
