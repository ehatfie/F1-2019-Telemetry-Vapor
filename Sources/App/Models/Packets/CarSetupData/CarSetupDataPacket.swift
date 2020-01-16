//
//  CarSetupDataPacket.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct CarSetupPacket {
    let header: PacketHeader
    let carSetups: [CarSetupData]
    
    init(header: PacketHeader, data: ByteBuffer) throws {
        self.header = header
        //TODO add carSetups read from data??
        self.carSetups = []
    }
}
