//
//  SessionDataPacket.swift
//
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct SessionDataPacket {
    let header: PacketHeader
    let weather: Int?                // uint8 0  = clear, 1  = lightCloud, 2  = overcast, 3  = lightRain, 4  = heavyRain, 5  = storm
    let trackTemperature: Int? //int8      // track temperature in degrees
    let airTemperature: Int? //int8        // air temperature in celcius
    
    let totalLaps: Int? //uint8            // total number of laps in the race
    let trackLength: Int? // uint16         // track lenght in meters
    let sessionType: Int? // uint8          // 0  = unknown, 1  = Practice 1, 2  = Practice 2, 3  = Practice 3, 4  = short practice 5  = Q1, 6  = Q2, 7  = Q3, 8  = short Qualifying, 9  = One Shot Qualifying, 10  = Race, 11  = Race2, 12  = Time Trial
    let trackId: Int? // int8               //  -1 for uknown 0 =21 for tracks in season order
    let m_formula: Int? // uint8            // Formula type, 0 = F1 Modern, 1 = F1 Classic, 2 = F2
    
    let sessionTimeLeft: Int? // uint16     // time left in session in seconds
    let sessionDuration: Int? // uint16     // session duration in seconds
    
    let pitSpeedLimiter: Int? // uint8        // pit speed limit in km/h
    
    let gamePaused: Int? // Uint8           // whether game is paused
    let isSpectating: Int? // uint8         // whether player is spectating
    let spectatorCarIndex: Int? // uint8    // index of car being spectated
    let sliProNativeSupport: Int? // uint8  // 0 = inactive, 1 = active
    
    let numMarshalZones: Int? // uint8      // number of marshal zones max 21
    let marshalZones: [MarshalZone] // list of marshal zones
    let safetyCarStatus: Int? // uint8      // 0 = no safety car, 1 = full safety car, 2 = virtual safety car
    let networkGame: Int? // uint8          // 0 = offline, 1 = online
    let id: String // teamId
    
    init(header: PacketHeader, data: ByteBuffer) throws {
        self.header = header
        
        var dataCopy = data
        
        self.weather = dataCopy.readInt(as: Int8.self)
        self.trackTemperature = dataCopy.readInt(as: Int8.self)
        self.airTemperature = dataCopy.readInt(as: Int8.self)
        
        self.totalLaps = dataCopy.readInt(as: Int8.self)
        self.trackLength = dataCopy.readInt(as: Int16.self)
        self.sessionType = dataCopy.readInt(as: Int8.self)
        self.trackId = dataCopy.readInt(as: Int8.self)
        self.m_formula = dataCopy.readInt(as: Int8.self)
        
        self.sessionTimeLeft = dataCopy.readInt(as: Int16.self)
        self.sessionDuration = dataCopy.readInt(as: Int16.self)
        
        self.pitSpeedLimiter = dataCopy.readInt(as: Int8.self)
        
        self.gamePaused = dataCopy.readInt(as: Int8.self)
        self.isSpectating = dataCopy.readInt(as: Int8.self)
        self.spectatorCarIndex = dataCopy.readInt(as: Int8.self)
        self.sliProNativeSupport = dataCopy.readInt(as: Int8.self)
        
        
        self.numMarshalZones = dataCopy.readInt(as: Int8.self)
        
        var raceMarshalZones = [MarshalZone]()
        for _ in 0...4 {
            raceMarshalZones.append(try MarshalZone(data: dataCopy))
            //let temp1: Float? = dataCopy.readFloat()
            //let temp2 = dataCopy.readInt(as: Int8.self)
        }
        
        self.marshalZones = raceMarshalZones
        self.safetyCarStatus = dataCopy.readInt(as: Int8.self)
        self.networkGame = dataCopy.readInt(as: Int8.self)
        self.id = TeamIDs[dataCopy.readInt(as: Int8.self) ?? 404] ?? "NO SESSION TEAM ID"
    }
}
