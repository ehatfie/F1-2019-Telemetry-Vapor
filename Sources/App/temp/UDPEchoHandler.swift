//
//  File.swift
//  
//
//  Created by Erik Hatfield on 12/29/19.
//

import Foundation
import NIO

final class UdpEchoHandle1r: ChannelInboundHandler {
    // AddressedEnvelope is used to handle Datagrams (like udp)
    typealias InboundIn = AddressedEnvelope<ByteBuffer>
    var bigCounter = 0
    
    public func channelRead(ctx: ChannelHandlerContext, data: NIOAny) {
        print("CHANNEL READ")
        // unwrite data
        var addressedEnvelope = self.unwrapInboundIn(data)
        let readableBytes = addressedEnvelope.data.readerIndex

        var counter = 0
        var byteBuffer = addressedEnvelope.data
        
        var packetFormat = byteBuffer.readInteger(endianness: .little, as: uint16.self)
        print("packetFormat \(packetFormat)")
        
        var gameMajorVersion = byteBuffer.readInteger(endianness: .little, as: uint8.self)
        print("game mahjr version \(gameMajorVersion)")
        
        let gameMinorVersion = byteBuffer.readInteger(endianness: .little, as: uint8.self)
        print("game minor version \(gameMinorVersion)")
        
        let packetVersion = byteBuffer.readInteger(endianness: .little, as: uint8.self)
        print("packet version\(packetVersion)")
        
        let packetId = byteBuffer.readInteger(endianness: .little, as: uint8.self)
        print("packetId \(packetId)")
        
        let sessionUID = byteBuffer.readInteger(endianness: .little, as: uint64.self)
        print("sessionUID \(sessionUID)")
        
        let sessionTime = byteBuffer.readFloat()
        print("session time \(sessionTime)")
        
        let frameIdentifier = byteBuffer.readInteger(endianness: .little, as: uint32.self)
        print("frame identifier \(frameIdentifier)")
        
        let playerCarIndex = byteBuffer.readInteger(endianness: .little, as: uint8.self)
        print("playerCarIndex \(playerCarIndex)")
        
        print("Recieved from \(addressedEnvelope.remoteAddress)")
        // update context with data
        ctx.write(data, promise: nil)
        bigCounter += 1
    }
    
    public func channelReadComplete(ctx: ChannelHandlerContext) {
        // clear context
        print("channel read complete")
        ctx.flush()
    }
    
    public func errorCaught(ctx: ChannelHandlerContext, error: Error) {
        debugPrint("ErrorCAUGHT: \(error)")
        
        ctx.close(promise: nil)
    }
}
