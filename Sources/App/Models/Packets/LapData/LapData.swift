//
//  LapData.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import Vapor
import NIO

struct LapData {
    let lastLapTime: Float?
    let currentLapTime: Float?
    let bestLapTime: Float?          // best lap time of the session
    
    let sector1Time: Float?          // sector 1 time in seconds
    let sector2Time: Float?          // sector 2 time in seconds
    
    let lapDistance: Float?          // distance car is around current lap in meters
    let totalDistance: Float?        // total distance travelled in session in meters
    
    let safetyCarDelta: Float?       // delta in seconds for safety car
    let carPosition: Int?            // uint8 car race position
    let currentLapNum: Int?          // uint8
    let pitStatus: Int?              // uint8 0 = none, 1 = pitting, 2 = in pits
    let sector: Int?                 // uint8 0 = sector1, 1 = sector2, etc
    let currentLapInvalid: Int?      // uint8 0 =  valid, 1 = invalid
    let penalties: Int?              // uint8 accumulated time penalties in seconds
    let gridPosition: Int?           // uint8 grid position vehicle started in
    let driverStatus: Int?           // uint8 0 = inGarage, 1 = flyingLap, 2 = inLap, 3 = outLap, 4 = onTrack
    let resultStatus: Int?           // uint8 0 = invalid, 1 = inactive, 2 = active, 3 = finished, 4 = disqualified, 5 = notClassified, 6 = retired
    
    init(data: ByteBuffer) throws {
        var dataCopy = data
        
        
        self.lastLapTime = dataCopy.readFloat()
        self.currentLapTime = dataCopy.readFloat()
        self.bestLapTime = dataCopy.readFloat()
        
        self.sector1Time = dataCopy.readFloat()
        self.sector2Time = dataCopy.readFloat()
        
        self.lapDistance = dataCopy.readFloat()
        self.totalDistance = dataCopy.readFloat()
        
        self.safetyCarDelta = dataCopy.readFloat()
        self.carPosition = dataCopy.readInt(as: UInt8.self)
        self.currentLapNum = dataCopy.readInt(as: UInt8.self)
        self.pitStatus = dataCopy.readInt(as: UInt8.self)
        self.sector = dataCopy.readInt(as: UInt8.self)
        self.currentLapInvalid = dataCopy.readInt(as: UInt8.self)
        self.penalties = dataCopy.readInt(as: UInt8.self)
        self.gridPosition = dataCopy.readInt(as: UInt8.self)
        self.driverStatus = dataCopy.readInt(as: UInt8.self)
        self.resultStatus = dataCopy.readInt(as: UInt8.self)
    }
    
}



