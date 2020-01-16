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
        //let foo: String? = addressedEnvelope.
        
        //var data2 = addressedEnvelope.data.readableBytesView
        //let string = String(bytes: data2, encoding: .ut)
        //print("STRING \(string)")
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

public func startUDP() {
    print("UDP ECHo START")
    // creates event loop group on number of threads available to system
    let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount-4)
    
    let channelSocketOption = (SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR)
    
    let datagramBootstrap = DatagramBootstrap(group: group)
        .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
        .channelInitializer({ channel in
            print("CHANNEL")
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
        
        print("Channel accepting connections on \(channel.localAddress!) \(channel.register())")
        
        let socketAddress = try SocketAddress(ipAddress: bindToAddress, port: defaultPort)
        let byteBuffer = ByteBuffer(ByteBufferView())
        
        let addressedEnvelope = AddressedEnvelope<ByteBuffer>.init(remoteAddress: socketAddress, data: byteBuffer)
        
        //try channel.write(addressedEnvelope).wait()
        channel.write(addressedEnvelope, promise: nil)
        try channel.closeFuture.wait()
        
    } catch {
        print("ERROR CATCH")
    }
    
    print("Channel closed")
}

