//
//  PacketEvent.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

enum EventStringCode: String {
    case SSTA = "SSTA" // session started
    case SEND = "SEND" // session ended
    case FTLP = "FTLP" // fastest lap
    case RTMT = "RTMT" // retirement
    case DRSE = "DRSE" // drs enabled
    case DRSD = "DRSD" // drs disabled
    case TMPT = "TMPT" // team mate in pits
    case CHQF = "CHQF" // chequered flag
    case RCWN = "RCWN" // race winner
    case ERRO = "ERROR" // error
}

struct EventDataPacket {
    let header: PacketHeader
    let eventStringCode: EventStringCode
    let vehicleIdx: Int?         // uint8
    let lapTime: Float?
    
    init(header: PacketHeader, data: ByteBuffer) throws {
        self.header = header
        var dataCopy = data
        
        self.eventStringCode = EventStringCode(rawValue: dataCopy.readString(length: 4) ?? "ERROR") ?? .ERRO
        self.vehicleIdx = dataCopy.readInt(as: UInt8.self)
        self.lapTime = dataCopy.readFloat()
    }
}
