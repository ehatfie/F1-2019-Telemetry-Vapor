//
//  Packet.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

 protocol Packet {
    var header: PacketHeader { get set }
}

struct PacketHeader {
    let packetFormat: Int? //uint16 // game year packet type eg 2019
    let gameMajorVersion: Int? //uint8 // vX.00
    let gameMinorVersion: Int? //uint8 // v1.XX
    let packetVersion:  Int? //uint8 //version of packet type
    let packetId: Int? //uint8 // packet type
    let sessionUID: Int? //uint64 // unique session identifier
    let sessionTime: Float? // session timestamp
    let frameIdentifier: Int? // uint32 // Identifier for which frame the packet was retrieved on
    let playerCarIndex: Int? //uint8 // index of players car
    
    init(data: ByteBuffer) throws {
        var dataCopy = data
        
        self.packetFormat = dataCopy.readInt(as: UInt16.self)
        self.gameMajorVersion = dataCopy.readInt(as: UInt8.self)
        self.gameMinorVersion = dataCopy.readInt(as: UInt8.self)
        self.packetVersion = dataCopy.readInt(as: UInt8.self)
        self.packetId = dataCopy.readInt(as: UInt8.self)
        self.sessionUID = dataCopy.readInt(as: UInt64.self)
        self.sessionTime = dataCopy.readFloat()
        self.frameIdentifier = dataCopy.readInt(as: UInt32.self)
        self.playerCarIndex = dataCopy.readInt(as: UInt8.self)
    }
}
