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
    
    init(data: inout ByteBuffer) throws {
        self.lastLapTime = data.readFloat()
        self.currentLapTime = data.readFloat()
        self.bestLapTime = data.readFloat()
        
        self.sector1Time = data.readFloat()
        self.sector2Time = data.readFloat()
        
        self.lapDistance = data.readFloat()
        self.totalDistance = data.readFloat()
        
        self.safetyCarDelta = data.readFloat()
        self.carPosition = data.readInt(as: UInt8.self)
        self.currentLapNum = data.readInt(as: UInt8.self)
        self.pitStatus = data.readInt(as: UInt8.self)
        self.sector = data.readInt(as: UInt8.self)
        self.currentLapInvalid = data.readInt(as: UInt8.self)
        self.penalties = data.readInt(as: UInt8.self)
        self.gridPosition = data.readInt(as: UInt8.self)
        self.driverStatus = data.readInt(as: UInt8.self)
        self.resultStatus = data.readInt(as: UInt8.self)
    }
    
}



