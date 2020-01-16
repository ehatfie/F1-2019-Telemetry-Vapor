//
//  EchoHandler.swift
//  App
//
//  Created by Erik Hatfield on 1/15/20.
//

import Foundation
import NIO

final class UdpEchoHandler: ChannelInboundHandler {
    typealias InboundIn = AddressedEnvelope<ByteBuffer>
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        print("CHANNEL READ")
        var addressedEnvelope = self.unwrapInboundIn(data)
        let readableBytes = addressedEnvelope.data.readerIndex
        
        var byteBuffer = addressedEnvelope.data
        
        var packetFormat = byteBuffer.readInt(as: UInt16.self)
        print("PACKET FORMAT \(packetFormat)")
    }
}
