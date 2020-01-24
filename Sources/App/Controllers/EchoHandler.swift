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
        let addressedEnvelope = self.unwrapInboundIn(data)
        let readableBytes = addressedEnvelope.data.readerIndex
        
        var byteBuffer = addressedEnvelope.data
        
        do {
            let header = try PacketHeader(data: &byteBuffer)
            let packetInfo = try PacketInfo(format: header.packetFormat, version: header.packetVersion, type: header.packetId)
            if let handler = HeaderFieldsToPacketType[packetInfo] {
                handler.processPacket(data: &byteBuffer)
            }
            
        } catch {
            print("ERROR WITH HEADER")
        }
    }
    
    func read(data: inout ByteBuffer) throws {
        
        let header = try PacketHeader(data: &data)
        print("HEADER \(header)")
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
    let bindToAddress = "192.168.1.119"
    
    do {
        let channel = try datagramBootstrap.bind(host: bindToAddress, port: port).wait()

        print("Channel accepting connections on \(channel.localAddress!))")
        
        try channel.closeFuture.wait()
        
    } catch {
        print("ERROR CATCH")
    }

    print("Channel closed")
}
//testing
func getUdpEventLoop() -> EventLoopFuture<Void> {
    let group = MultiThreadedEventLoopGroup(numberOfThreads: 4)
    let future = group.future()

    return future
}
