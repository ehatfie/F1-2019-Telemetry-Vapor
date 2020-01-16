//
//  LapDataPacket.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct LapDataPacket {
    /**
     The lap data packet gives details of all the cars in the session.
     Frequency: Rate as specified in menus
     Size: 843 bytes
     Version: 1
     */
    let header: PacketHeader
    let lapData: [LapData] // lap data for all cars on track
    
    init(header: PacketHeader, data: ByteBuffer) {
        self.header = header
        self.lapData = []
    }
}
