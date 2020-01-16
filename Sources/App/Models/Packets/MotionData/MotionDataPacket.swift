//
//  CarMotionDataPacket.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import Vapor

struct MotionDataPacket {
    let header: PacketHeader
    var carMotionData: [CarMotionData]
    
    /*
     TODO:
     suspensionPosition RL, RR, FL, FR
     suspensionVelocity RL, RR, FL, FR
     suspensionAcceleration RL, RR, FL, FR
     wheelSpeed RL, RR, FL, FR
     wheelSlip RL, RR, FL, FR
     */
    
    // velocities in local space
    let localVelocityX: Float?
    let localVelocityY: Float?
    let localVelocityZ: Float?
    
    let angularVelocityX: Float?
    let angularVelocityY: Float?
    let angularVelocityZ: Float?
    
    let angularAccelerationX: Float?
    let angularAccelerationY: Float?
    let angularAccelerationZ: Float?
    
    // current front wheel angle in raidians
    var frontWheelsAngle: Float?
    
    init(header: PacketHeader, data: ByteBuffer) throws {
        self.header = header
        
        var dataCopy = data
        // add read for todo above
        carMotionData = []
        for _ in 0...4 {
            
        }
        
        
        self.localVelocityX = dataCopy.readFloat()
        self.localVelocityY = dataCopy.readFloat()
        self.localVelocityZ = dataCopy.readFloat()
        
        self.angularVelocityX = dataCopy.readFloat()
        self.angularVelocityY = dataCopy.readFloat()
        self.angularVelocityZ = dataCopy.readFloat()
        
        self.angularAccelerationX = dataCopy.readFloat()
        self.angularAccelerationY = dataCopy.readFloat()
        self.angularAccelerationZ = dataCopy.readFloat()
        
        self.frontWheelsAngle = dataCopy.readFloat()
    }
}

