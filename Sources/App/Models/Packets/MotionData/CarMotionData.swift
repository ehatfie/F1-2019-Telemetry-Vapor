//
//  CarMotionData.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import Vapor

//TODO: add description
struct CarMotionData {
    let worldPositionX: Float?
    let worldPositionY: Float?
    let worldPositionZ: Float?
    
    let worldVelocityX: Float?
    let worldVelocityY: Float?
    let worldVelocityZ: Float?
    
    let worldForwardDirX: Int?   // Int16
    let worldForwardDirY: Int?   // Int16
    let worldForwardDirZ: Int?   // Int16
    
    let worldRightDirX: Int?     // Int16
    let worldRightDirY: Int?     // Int16
    let worldRightDirZ: Int?     // Int16
    
    let gForceLateral: Float?
    let gForceLongitudinal: Float?
    let gForceVertical: Float?
    
    let yaw: Float?
    let pitch: Float?
    let roll: Float?
    
    init(data: ByteBuffer) throws {
        var dataCopy = data
        
        
        //let val: Float? = try dataCopy.readInteger(endianness: .little, as: UInt32.self)
        
        self.worldPositionX = dataCopy.readFloat()
        self.worldPositionY = dataCopy.readFloat()
        self.worldPositionZ = dataCopy.readFloat()
        
        self.worldVelocityX = dataCopy.readFloat()
        self.worldVelocityY = dataCopy.readFloat()
        self.worldVelocityZ = dataCopy.readFloat()
        
        self.worldForwardDirX = dataCopy.readInt(as: UInt16.self)
        
        self.worldForwardDirY = dataCopy.readInt(as: UInt16.self)
        self.worldForwardDirZ = dataCopy.readInt(as: UInt16.self)
        
        self.worldRightDirX = dataCopy.readInt(as: UInt16.self)
        self.worldRightDirY = dataCopy.readInt(as: UInt16.self)
        self.worldRightDirZ = dataCopy.readInt(as: UInt16.self)
        
        self.gForceLateral = dataCopy.readFloat()
        self.gForceLongitudinal = dataCopy.readFloat()
        self.gForceVertical = dataCopy.readFloat()
        
        self.yaw = dataCopy.readFloat()
        self.pitch = dataCopy.readFloat()
        self.roll = dataCopy.readFloat()
    }
}


extension ByteBuffer {
    mutating func readInt<T: FixedWidthInteger>(as: T.Type = T.self) -> Int? {
        guard let data = self.readInteger(endianness: .little, as: T.self) else { return nil }
        return Int(truncatingIfNeeded: data)
    }
    
    mutating func readFloat() -> Float? {
        var data1 = [UInt8]()
        
        for _ in 0..<4 {
            guard let data = self.readInteger(endianness: .little, as: UInt8.self) else { return nil }
            data1.append(data)
        }
        
        let dataObject = Data(data1)
        
        return dataObject.withUnsafeBytes({$0.load(as: Float.self)})
    }
}
