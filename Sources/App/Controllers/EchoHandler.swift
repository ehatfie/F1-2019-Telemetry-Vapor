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
        var addressedEnvelope = self.unwrapInboundIn(data)
        let readableBytes = addressedEnvelope.data.readerIndex
        
        var byteBuffer = addressedEnvelope.data
        
        var packetFormat = byteBuffer.readInt(as: UInt16.self)
        print("PACKET FORMAT \(packetFormat)")
    }
}

public func startUDP() {
    // creates event loop group on number of threads available to system
    let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    
    let channelSocketOption = (SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR)
    
    let datagramBootstrap = DatagramBootstrap(group: group)
        .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
        .channelInitializer({ channel in
            return channel.pipeline.addHandler(UdpEchoHandler())
        })
    
    defer {
        print("DEFER")
        try! group.syncShutdownGracefully()
    }
    
    let defaultPort = 20777
    
    let arguments = CommandLine.arguments
    
    let port = arguments.dropFirst() // drop first argument
        .compactMap {Int($0)} // remove nil values and convert to Int
        .first ?? defaultPort // get port or use default if no valid port was provided
    
    // TODO: get this address from commandline
    let bindToAddress = "127.0.0.1"
    
    do {
        let channel = try datagramBootstrap.bind(host: bindToAddress, port: port).wait()
        
        print("Channel accepting connections on \(channel.localAddress!))")
        
        try channel.closeFuture.wait()
        
    } catch {
        print("ERROR CATCH")
    }
    
    print("Channel closed")
}
