//
//  ParticipantDataPacket.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation

struct ParticipantDataPacket {
    let header: PacketHeader
    let numActiveCars: Int
    let participants: [ParticipantData]
    
    init(header: PacketHeader) {
        self.header = header
        self.numActiveCars = 99
        self.participants = []
    }
}
