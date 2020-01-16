//
//  CarSetupData.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct CarSetupData {
    let frontWing: Int? // uint8.self
    let rearWing: Int? // uint8.self
    
    let onThrottle: Int? // uint8.self, Diff adjustment on throttle %
    let offThrottle: Int? // uint8.self, Diff adjustment off throttle %
    
    let frontCamber: Float? // front camber angle
    let rearCamber: Float? // rear camber angle
    
    let frontToe: Float?
    let rearToe: Float?
    
    let frontSuspension: Int? // uint8.self
    let rearRuspension: Int? // uint8.self
    
    let frontAntiRollBar: Int? // uint8.self
    let rearAntiRollBar: Int? // uint8.self
    
    let frontSuspensionHeight: Int? // uint8.self
    let rearSuspensionHeight: Int? // uint8.self
    
    let brakePressure: Int? // uint8.self, percentage
    let brakeBias: Int? // uint8.self, percentage
    
    let frontTirePressure: Float? // PSI
    let rearTirePressure: Float? // PSI
    
    let ballast: Int? // uint8.self
    let fuelLoad: Float?
    
    init(data: ByteBuffer) throws {
        var dataCopy = data
        
        self.frontWing = dataCopy.readInt(as: UInt8.self)
        self.rearWing = dataCopy.readInt(as: UInt8.self)
        
        self.onThrottle = dataCopy.readInt(as: UInt8.self)
        self.offThrottle = dataCopy.readInt(as: UInt8.self)
        
        self.frontCamber = dataCopy.readFloat()
        self.rearCamber = dataCopy.readFloat()
        
        self.frontToe = dataCopy.readFloat()
        self.rearToe = dataCopy.readFloat()
        
        self.frontSuspension = dataCopy.readInt(as: UInt8.self)
        self.rearRuspension = dataCopy.readInt(as: UInt8.self)
        
        self.frontAntiRollBar = dataCopy.readInt(as: UInt8.self)
        self.rearAntiRollBar = dataCopy.readInt(as: UInt8.self)
        
        self.frontSuspensionHeight = dataCopy.readInt(as: UInt8.self)
        self.rearSuspensionHeight = dataCopy.readInt(as: UInt8.self)
        
        self.brakePressure = dataCopy.readInt(as: UInt8.self)
        self.brakeBias = dataCopy.readInt(as: UInt8.self)
        
        self.frontTirePressure = dataCopy.readFloat()
        self.rearTirePressure = dataCopy.readFloat()
        
        self.ballast = dataCopy.readInt(as: UInt8.self)
        self.fuelLoad = dataCopy.readFloat()
    }
}
